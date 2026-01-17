# AGENTS.md

## 1. Project Context & Role
**Role:** Senior NixOS Systems Engineer & DevOps Specialist.
**Goal:** Maintain, refactor, and extend a declarative NixOS configuration using Flakes, Home Manager, and SOPS.
**Core Principles:** Reproducibility, Idempotency, Modularity, and Type Safety.

## 2. Technology Stack
*   **System:** NixOS (Unstable/Rolling via Flakes).
*   **User Management:** Home Manager (Standalone or Module).
*   **Secrets:** SOPS-Nix (AGE encryption).
*   **Window Manager:** Niri (Primary), Mango (Legacy/On-Hold).
*   **Language Server:** `nixd` (Must be used for code analysis and completions).
*   **Formatter:** `alejandra` (Must be applied to all `.nix` outputs).
*   **Dev Environment:** `devenv` (Managed via `devenv.nix`).

## 3. Repository Architecture & Navigation
The repository is split into two distinct logic domains: **Host Configuration** (System) and **Home Configuration** (User).

### A. Root Directory
*   `flake.nix`: The entry point. Defines inputs (nixpkgs, home-manager, nvf, etc.) and outputs (nixosConfigurations).
*   `flake.lock`: Source of truth for dependency versions.
*   `devenv.nix`: Developer shell configuration for working on *this* repo.

### B. Host Configuration (`hosts/utkar/`)
*   **Purpose:** System-level settings, hardware drivers, bootloaders, networking, and virtualization.
*   **Key Files:**
    *   `configuration.nix`: Main import hub for the host.
    *   `hardware-configuration.nix`: Auto-generated hardware map (rarely edit manually).
    *   `packages.nix`: **System-wide** packages only (e.g., drivers, system utils).
    *   `services.nix`: Systemd services (podman, ssh, pipewire).
    *   `virtualisation.nix`: VM/Container logic.

### C. Home Configuration (`home/utkar/`)
*   **Purpose:** User-space tools, dotfiles, styling, and application configuration.
*   **Categorization:**
    *   `audio/`: Audio-related configurations (e.g., `easyeffects.nix`).
    *   `browser/`: Browser configurations (e.g., `qutebrowser.nix`).
    *   `cli/`: Command line tools.
        *   **Active:** `dank-material-shell.nix`, `fzf.nix`, `git.nix`, etc.
    *   `editor/`: Text editors.
        *   **Active:** `helix.nix`.
        *   **Semi-Retired:** `nvf-nvim.nix` (Maintain only if critical; waiting for upstream fixes).
    *   `file-manager/`: File manager configurations (e.g., `yazi.nix`).
    *   `gaming/`: Gaming-related configurations (e.g., `lutris.nix`).
    *   `mango/`: **[SEMI-RETIRED]** Custom window management configs/scripts. Preserve content but do not actively develop.
    *   `multiplexer/`: `zellij` and `conky` configurations.
    *   `shell/`: Shell logic (`fish`, `zsh`, `starship`).
    *   `terminal/`: Terminal emulators (`ghostty`, `kitty`, `wezterm`).

### D. Secrets (`secrets/`)
*   Contains encrypted `secrets.yaml`.
*   **WARNING:** Never output raw secret values in chat. Only reference the path or the sops config.

## 4. Coding Standards & Style Guide

### Formatting (Alejandra)
*   All Nix code **must** be formatted using `alejandra`.
*   Indent with 2 spaces.
*   Vertical alignment of lists and attribute sets is required.

### Syntax Preferences
*   **Imports:** Use relative paths.
    ```nix
    imports = [ ./module.nix ]; # Correct
    ```
*   **Lambda Arguments:** Prefer explicit argument listing over `...` when possible, but allow `...` for module passthrough.
    ```nix
    { pkgs, config, lib, ... }: # Preferred
    ```
*   **`let ... in`:** Use local scoping for complex variables or path manipulations.
*   **Strings:** Use multi-line strings (`''`) for config files or shell scripts embedded in Nix.

### LSP (Nixd)
*   Assume `nixd` is analyzing the `flake.nix` entry point.
*   When fixing errors, prioritize `nixd` diagnostics regarding scope and unused variables.

## 5. Workflow Protocols

### Task: Adding a New Package
1.  **Decision:** Is this for the system root or the user `utkar`?
    *   *System:* Edit `hosts/utkar/packages.nix`.
    *   *User:* Edit `home/utkar/cli/` (or create a new category if necessary).
2.  **Implementation:**
    *   Search for the package attribute name (use `nix search` logic).
    *   Add to `home.packages` or `environment.systemPackages`.

### Task: Configuring an Existing Module
1.  Locate the relevant file (e.g., `home/utkar/browser/qutebrowser.nix`).
2.  Use `programs.qutebrowser = { enable = true; ... }` syntax.
3.  Do not edit generated config files directly; edit the Nix module.

### Task: Managing Secrets (SOPS)
1.  **Editing:** Instruction is to use `sops secrets/secrets.yaml`.
2.  **Integration:**
    *   Ensure `sops-nix` is imported in `hosts/utkar/configuration.nix` or the relevant home module.
    *   Reference secrets via `config.sops.secrets."secret_name".path`.

### Task: Creating New Modules
1.  Create the file (e.g., `home/utkar/tools/newtool.nix`).
2.  Standard boilerplate:
    ```nix
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ newtool ];
      # or
      programs.newtool.enable = true;
    }
    ```
3.  **Import:** You must import this new file in the parent `home.nix` or relevant `imports` list for it to take effect.
4.  **GIT TRACKING (CRITICAL):** You **must** run `git add <new_file>` immediately. Nix Flakes will not detect the file if it is not staged in git, resulting in "file not found" errors during build/check.

## 6. Specific Module Awareness

### Active Components
*   **Window Manager:** `niri` is the active target. Ensure configurations align with Niri's Wayland requirements.
*   **Shell Integration:** `dank-material-shell.nix` (in `home/utkar/cli`) is the primary shell styling/utility component.
*   **Editor:** `helix` (`home/utkar/editor/helix.nix`) is the daily driver. Prioritize Helix configuration changes over Neovim.

### Semi-Retired / On-Hold
*   **Neovim (NVF):** `home/utkar/editor/nvf-nvim.nix` is semi-retired. The user plans to return to it later; keep the config valid but do not focus on feature additions unless requested.
*   **Mango:** The `mango/` directory and associated custom scripts are semi-retired. Do not delete, but assume `niri` supersedes these configs for now.

### Shell & Prompt
*   The setup is hybrid. `shell/fish.nix` and `shell/zsh.nix` exist.
*   Prompts are heavily customized (`starship`, `prezto`, `zephyr`) in `shell/prompt/`.

## 7. Change Verification
Before confirming a task is complete, the Agent should conceptually verify:
1.  **Git Status:** Have new files been added (`git add`)?
2.  **Syntax:** Is the syntax valid?
3.  **Imports:** Is the module imported in the dependency tree?
4.  **Dependencies:** Are all dependencies (pkgs) available in the flake inputs?
5.  **Locks:** Does the change modify `flake.lock`? (Mention this if true).

## 8. Common Commands (Reference)
*   **Apply System:** `nixos-rebuild switch --flake .#utkar`
*   **Apply Home:** `home-manager switch --flake .#utkar` (or relies on NixOS module integration).
*   **Update Flake:** `nix flake update`
*   **Format:** `alejandra .`
*   **Check:** `git add . && nix flake check` (Ensure files are staged first!)
