# flake-parts Migration Plan — Canikks' Dotfiles

> **Goal**: Convert the monolithic `flake.nix` (167 lines, 52 inputs, 32 with manual `follows`, manual output wiring) into a modular `flake-parts` architecture while keeping the existing concern-centric internal module structure intact.
>
> **Guiding philosophy**: Minimal disruption to existing module files. The migration primarily changes *how outputs are wired* in `flake.nix` and introduces `flake-module.nix` files. Existing `hosts/utkar/*.nix` and `home/utkar/**/*.nix` files should require **zero changes** to their internal logic.

---

## 1. Current Architecture Summary

```
flake.nix (167 lines)
├── 52 inputs, 32 with manual `follows`
├── outputs:
│   ├── formatter.x86_64-linux = alejandra
│   ├── nixosConfigurations.utkar = lib.nixosSystem {
│   │     modules = [
│   │       ./hosts/utkar/configuration.nix  # imports 11 other host modules
│   │       + 20 flake-provided NixOS modules
│   │       { home-manager.users.utkar = import ./home/utkar/home.nix; }
│   │     ]
│   │   }
│   └── devShells.x86_64-linux.default = devenv.mkShell { modules = [ ./devenv.nix ] }
```

### Key observations

| Aspect | Current State | Problem |
|--------|---------------|---------|
| **Input follows** | 32 manual `follows = "nixpkgs"` lines | Boilerplate, easily missed on new inputs |
| **System repetition** | `system = "x86_64-linux"` hardcoded 3× | Not reusable for other architectures |
| **Home-manager** | Embedded IN the nixosConfigurations module | Works but breaks separation of concerns |
| **Overlay propagation** | `home.nix` reads `self.nixosConfigurations.utkar.config.nixpkgs.overlays` | Fragile circular-ish dependency |
| **Formatters/devShells** | Manual `system` attribute sets | Flake-parts handles this automatically |

---

## 2. Target flake-parts Architecture

### New file layout

```
flake.nix                 → Thin mkFlake wrapper (~25 lines)
flake-module.nix          → All flake-level wiring (inputs, nixosConfig, homeConfig, perSystem)
hosts/utkar/              → UNCHANGED (12 existing host modules)
home/utkar/               → UNCHANGED (existing HM modules)
secrets/                  → UNCHANGED
```

### Conceptual flake-parts module tree

```
flake.nix
└── mkFlake { ... }
    └── imports = [
        inputs.flake-parts.flakeModules.easyOverlay     (optional - for overlay auto-gen)
        ./flake-module.nix                               (the main wiring module)
    ]
    └── perSystem = { pkgs, system, ... }:
        └── formatter = pkgs.alejandra
        └── devShells.default = devenv.mkShell { ... }
        └── packages = { ... }                            (if any local packages)
    └── flake = {
        └── nixosConfigurations.utkar = nixpkgs.lib.nixosSystem { ... }
        └── homeConfigurations."utkar@utkar" = home-manager.lib.homeManagerConfiguration { ... }
    }
```

---

## 3. Phase-by-Phase Migration

### Phase 1: Core flake-parts Integration (safe, reversible)

**What changes**: `flake.nix` only. Everything else stays identical.

#### Step 1.1 — Add flake-parts input

```nix
flake-parts = {
  url = "github:hercules-ci/flake-parts";
};
```

#### Step 1.2 — Rewrite `outputs` as `mkFlake`

Replace the current `outputs = inputs: let ... in { ... }` pattern with:

```nix
outputs = inputs:
  inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];

    perSystem = { pkgs, ... }: {
      formatter = pkgs.alejandra;
      devShells.default = inputs.devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [ ./devenv.nix ];
      };
    };

    flake.nixosConfigurations.utkar = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = with inputs; [
        # ... same list as before, unchanged ...
      ];
    };

    imports = [
      # future: home-manager flake module
    ];
  };
```

**Verification**: `nix flake check` passes, `nixos-rebuild build` works, `nix develop` works.

#### Benefits unlocked in Phase 1:
- No more manual `follows` needed (removes ~32 lines of boilerplate)
- `formatter`, `devShells` auto-generate for all `systems`
- Module system catches option conflicts early

---

### Phase 2 — Extract `flake-module.nix` ✅ COMPLETE

**What changes**: `flake.nix` (thinner), new `flake-module.nix` (the actual wiring), new `hosts/utkar/home-manager.nix` (extracted inline block).

**Verified**: `nix flake check --impure` ✅ — all 9 outputs pass.

**Lessons learned**:
- ⚠️ `lib.nixosSystem` does NOT work in flake-parts modules. Use `inputs.nixpkgs.lib.nixosSystem` instead.
- ⚠️ When extracting inline modules via `import`, you MUST pass `pkgs` explicitly: `(import ./path/to/file.nix { inherit inputs self system pkgs; })`.

**What changes**: `flake.nix` (thinner), new `flake-module.nix` (the actual wiring).

#### Step 2.1 — Create `flake-module.nix`

```nix
{ inputs, lib, ... }: {
  flake.nixosConfigurations.utkar = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = with inputs; [
      ./hosts/utkar/configuration.nix
      niri-autoselect-portal.nixosModules.default
      niri.nixosModules.niri
      hyprland.nixosModules.default
      dank-material-shell.nixosModules.greeter
      dank-material-shell.nixosModules.dank-material-shell
      home-manager.nixosModules.home-manager
      nur.modules.nixos.default
      # ... rest of the list ...
      (import ./hosts/utkar/home-manager.nix { inherit inputs self system; })
    ];
  };
}
```

#### Step 2.2 — Extract the inline home-manager config

Move the inline `{ home-manager.users.utkar = ... }` block from `configuration.nix`'s imports into a separate file `hosts/utkar/home-manager.nix`:

```nix
# hosts/utkar/home-manager.nix
# NOTE: This is imported as a function, not a NixOS module:
#   (import ./home-manager.nix { inherit inputs self system; })
{ inputs, self, system, pkgs, ... }: {
  home-manager.useGlobalPkgs = false;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";
  home-manager.extraSpecialArgs = { inherit inputs self system; };
  home-manager.users.utkar = import ../../home/utkar/home.nix;
  home-manager.startAsUserService = true;
  home-manager.verbose = true;
  home-manager.backupCommand = "${pkgs.trash-cli}/bin/trash";
  home-manager.overwriteBackup = true;
}
```

#### Step 2.3 — Thin `flake.nix` to just:

```nix
{
  description = "My NixOS system configuration flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    # ... all other inputs (SAME LIST, NO `follows` needed!)
    home-manager.url = "github:nix-community/home-manager";
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem = { pkgs, ... }: {
        formatter = pkgs.alejandra;
        devShells.default = inputs.devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [ ./devenv.nix ];
        };
      };
      imports = [
        ./flake-module.nix
      ];
    };
}
```

**Verification**: `nix flake check`, `nix build .#nixosConfigurations.utkar.config.system.build.toplevel`

---

### Phase 3 — Standalone Home Manager Output ✅ COMPLETE

**What changed**:
- `flake.nix` — added `inputs.home-manager.flakeModules.home-manager` to imports
- `flake-module.nix` — added `flake.homeConfigurations."utkar@utkar"` using `inputs.home-manager.lib.homeManagerConfiguration`

**Verified**:
- `nix flake check --impure` ✅ — all outputs including `homeConfigurations` pass
- `nix eval '.#homeConfigurations."utkar@utkar".config.home.username'` → `"utkar"` ✅

**Lessons learned**:
- ⚠️ Standalone HM requires explicit `nix.package` for modules like `nix-index-database`: add a module `({ pkgs, ... }: { nix.package = pkgs.nix; })` to the modules list
- ⚠️ `nix-index-database` HM module asserts `nix.package` is set for generating `nix.conf` — not needed when embedded in NixOS (NixOS provides it)
- The `self`-based overlay reference in `home.nix` (line 65: `self.nixosConfigurations.utkar.config.nixpkgs.overlays`) works through lazy evaluation even in standalone HM mode — Nix lazily resolves the cross-reference without circularity
- `inputs.home-manager.flakeModules.home-manager` exposes `homeConfigurations` and `homeModules` as flake outputs (the `homeModules` warning from `nix flake check` is harmless — it's a flake-parts internal option)

---

### Phase 4 (Future): Dendritic Module Consolidation

**Motivation**: The host modules are already well-organized by concern, but moving reusable NixOS modules to `modules/nixos/` and HM modules to `modules/home/` makes them importable by future hosts.

| Current | Proposed |
|---------|----------|
| `hosts/utkar/services.nix` | → `modules/nixos/services/default.nix` + `hosts/utkar/services.nix` wiring |
| `hosts/utkar/programs.nix` | → `modules/nixos/programs/default.nix` + host wiring |
| `hosts/utkar/network.nix` | → `modules/nixos/network/default.nix` + host wiring |
| `home/utkar/cli/*.nix` | → `modules/home/cli/*.nix` + user wiring |
| `home/utkar/editor/*.nix` | → `modules/home/editor/*.nix` + user wiring |

This is **lower priority** — the existing layout is already functional and organized.

---

## 4. Detailed Comparison: Before vs After

### `flake.nix` line count

| Section | Before | After | Delta |
|---------|--------|-------|-------|
| Inputs | ~106 lines (52 inputs, 32 active follows) | ~74 lines (no follows) | **-32** |
| Outputs / mkFlake wrapper | ~55 lines | ~30 lines | **-25** |
| **Total flake.nix** | **167 lines** | **~105 lines** | **-62** |

> **Reality check**: Active `follows` count is **32**, not "50+". The "50+ lines of boilerplate" was an overestimate. Actual savings from dropping follows is **~32 lines**. The follow-up Phase 2 (extracting `flake-module.nix`) further thins `flake.nix` to ~70 lines.

### Input `follows` elimination

The following `follows` are **automatically deduplicated by flake-parts** via the `inputs` argument in `perSystem`:

```nix
# ALL of these become unnecessary:
home-manager.inputs.nixpkgs.follows = "nixpkgs";
dank-material-shell.inputs.nixpkgs.follows = "nixpkgs";
niri.inputs.nixpkgs.follows = "nixpkgs";
nvf.inputs.nixpkgs.follows = "nixpkgs";
# ... ~28 more ...
```


**Caveat**: If an input uses a *different* nixpkgs for a specific purpose (e.g., `ghostty` overlays), the `follows` may still be needed for that input.

---

## 5. Verification Strategy

Each phase must pass these checks before proceeding:

1. **`nix flake check --impure`** — No evaluation errors (pure eval will fail due to `builtins.readFile` calls for SOPS secrets in `nix.nix` and `services.nix`)
2. **`nix build .#nixosConfigurations.utkar.config.system.build.toplevel`** — Dry build succeeds
3. **`nix develop`** — Dev shell enters correctly
4. **`nix fmt`** — Formatter works (tests `perSystem` wiring)
5. **`nix eval --impure .#nixosConfigurations.utkar.config.nixpkgs.overlays`** — Overlays propagate

---

## 6. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| `self.nixosConfigurations.utkar.config.nixpkgs.overlays` breaks | Medium | Medium | Define overlays in a shared `let` binding |
| Home-manager flake module adds complexity | Low | Low | Skip Phase 3, keep HM embedded |
| Some inputs don't resolve pkgs correctly without `follows` | Low | Medium | Add explicit `follows` back per-input |
| `optnix` references to `inputs` break | Low | Low | `inputs` is still passed via `specialArgs` |
| `stylix` base16Scheme path breaks | Low | Low | Relative path is evaluated at build time |

---

## 7. Implementation Order

```
Phase 1 ──▶ Basic mkFlake wrapper ──▶ Verify: nix flake check, nix build
    │
    ▼
Phase 2 ──▶ Extract flake-module.nix ──▶ Verify: same checks
    │
    ▼
Phase 3 ──▶ (Optional) HM flake output ──▶ Verify: home-manager switch
    │
    ▼
Phase 4 ──▶ (Future) Dendritic reorg ──▶ Stretch goal
```

---

## 8. Estimated Effort

| Phase | Files Changed | Lines Changed | Estimated Time |
|-------|--------------|--------------|----------------|
| 1 | 1 (flake.nix) | ~60 (delete 32 follows, rewrite outputs) | 15 min |
| 2 | 2 (flake.nix, +flake-module.nix) | ~50 | 15 min |
| 3 | 2 (flake-module.nix, +hosts/utkar/home-manager.nix) | ~30 | 10 min |
| 4 | 30+ (move modules around) | ~100 (import path changes) | 1-2 hours |

**Total: ~40-60 min for Phases 1-3, 1-2 hours for Phase 4.**

---

## 9. Open Questions for Canikks-san

1. **Should home-manager stay embedded in the NixOS config (simpler), or become a separate `homeConfigurations` flake output (cleaner for standalone `home-manager switch`)?**
2. **The `self.nixosConfigurations.utkar.config.nixpkgs.overlays` reference in `home.nix`** — would you like to extract the overlays into a shared variable instead?
3. **Multi-system support** — add `aarch64-linux` to `systems` for future ARM builds?
4. **Phase 4 (Dendritic)** — interested in consolidating `hosts/utkar/*.nix` and `home/utkar/*` into `modules/` for cross-host reuse, or keep the current structure?