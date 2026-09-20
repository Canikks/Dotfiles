{
  self,
  inputs,
  ...
}: let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  lib = inputs.nixpkgs.lib;

  # ── Module registry ─────────────────────────────────────────────────────
  # Expose every .nix file under modules/ as an individually addressable
  # output (nixosModules.* / homeModules.*), named after its path relative
  # to modules/<class>/ with `/` and `-` folded into `_`. A directory's
  # default.nix takes the directory's name (it is that dir's aggregator,
  # matching the `imports = [ ./dir ]` semantics).
  #
  #   modules/nixos/boot.nix            -> nixosModules.boot
  #   modules/home/core.nix             -> homeModules.core
  #   modules/home/shell/fish.nix       -> homeModules.shell_fish
  #   modules/home/cli/git/default.nix  -> homeModules.cli_git
  #
  # Not registered (reachable via their parents instead):
  #   - browser/zen-stuff/*.nix: take {profileName, ...} injected by
  #     zen-browser.nix via _module.args — sub-modules, not standalone
  #   - non-Nix assets (*.lua/*.toml/*.kdl/*.glsl/config.json): data files
  # Consume from other flakes / internal wiring via:
  #   imports = with self.nixosModules; [ boot locale security ];
  registry = dir: let
    foldDash = builtins.replaceStrings ["-"] ["_"];
    go = prefix: dir: let
      entries = builtins.readDir dir;
      step = name: type:
        if type == "directory"
        then go (prefix ++ [name]) (dir + "/${name}")
        else if name == "default.nix"
        then [
          (lib.nameValuePair
            (foldDash (lib.concatStringsSep "_" prefix))
            (dir + "/${name}"))
        ]
        else if lib.hasSuffix ".nix" name
        then [
          (lib.nameValuePair
            (foldDash (lib.concatStringsSep "_" (prefix ++ [(lib.removeSuffix ".nix" name)])))
            (dir + "/${name}"))
        ]
        else []; # non-Nix asset: loaded by its sibling module
    in
      lib.concatLists (lib.mapAttrsToList step entries);

    pairs = go [] dir;
    names = map (p: p.name) pairs;
  in
    assert lib.assertMsg
    (lib.length names == lib.length (lib.unique names))
    "module registry: duplicate module name under ${toString dir}";
      builtins.listToAttrs pairs;
in {
  # NOTE: paths are relative to the FLAKE ROOT (this file lives at root),
  # and must stay inside the flake or the store copy can't resolve them.
  flake.nixosModules = registry ./modules/nixos;
  flake.homeModules = registry ./modules/home;

  flake.nixosConfigurations.utkar = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs self;};
    modules = with inputs; [
      ./hosts/utkar/configuration.nix
      niri-autoselect-portal.nixosModules.default
      niri.nixosModules.niri
      hyprland.nixosModules.default
      dms.nixosModules.dank-material-shell
      home-manager.nixosModules.home-manager
      nur.modules.nixos.default
      nur.repos.iopq.modules.nixos.xraya
      nur.legacyPackages.x86_64-linux.repos.iopq.modules.xraya
      nix-index-database.nixosModules.nix-index
      # mango.nixosModules.mango
      nixos-hardware.nixosModules.common-cpu-intel
      nixos-hardware.nixosModules.common-gpu-intel
      nixos-hardware.nixosModules.common-pc-laptop-ssd
      sops-nix.nixosModules.sops
      nixos-cli.nixosModules.nixos-cli
      # nirinit.nixosModules.nirinit
      stylix.nixosModules.stylix
      dux-plugin-registry.nixosModules.default
      hermes-agent.nixosModules.default
      optnix.nixosModules.optnix
      surge.nixosModules.default
      # nyx-loner.nixosModules.default
      tlp-power-profile.nixosModules.default
      chaotic.nixosModules.default
      dux-calendar.nixosModules.default
      dux-greeter.nixosModules.default
      nvf.nixosModules.default
      noctalia.nixosModules.default
      noctalia-greeter.nixosModules.default
      nix-minecraft.nixosModules.minecraft-servers
      qtengine.nixosModules.default
      umbriel.nixosModules.default
      ambxst.nixosModules.default
      # dux-files.nixosModules.dux-files
      # dux-files.homeModules.dux-files
      (import ./hosts/utkar/home-manager.nix {inherit inputs self system pkgs;})
    ];
  };
}
