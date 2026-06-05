{
  self,
  inputs,
  ...
}: let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in {
  # Registered NixOS modules (referenced as self.nixosModules.*)
  flake.nixosModules = {
    locale = import ./modules/nixos/locale.nix;
    appearance = import ./modules/nixos/appearance.nix;
    portals = import ./modules/nixos/portals.nix;
    secrets = import ./modules/nixos/secrets.nix;
    security = import ./modules/nixos/security.nix;
    users = import ./modules/nixos/users.nix;
    packages = import ./modules/nixos/packages.nix;
    programs = import ./modules/nixos/programs.nix;
    services = import ./modules/nixos/services.nix;
    environment = import ./modules/nixos/environment.nix;
    network = import ./modules/nixos/network.nix;
    hardware = import ./modules/nixos/hardware.nix;
    boot = import ./modules/nixos/boot.nix;
    virtualisation = import ./modules/nixos/virtualisation.nix;
    nix = import ./modules/nixos/nix.nix;
    systemd = import ./modules/nixos/systemd.nix;
  };

  # Registered Home Manager modules (referenced as self.homeModules.*)
  flake.homeModules = {
    shell = import ./modules/home/shell;
    terminal = import ./modules/home/terminal;
    editor = import ./modules/home/editor;
    apps = import ./modules/home/apps;
    file-manager = import ./modules/home/file-manager;
    cli = import ./modules/home/cli;
    browser = import ./modules/home/browser;
    gaming = import ./modules/home/gaming;
    multiplexer = import ./modules/home/multiplexer;
    audio = import ./modules/home/audio;
    desktop-shell = import ./modules/home/desktop-shell;
    core = import ./modules/home/core.nix;
  };

  flake.nixosConfigurations.utkar = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs self;};
    modules = with inputs; [
      ./hosts/utkar/configuration.nix
      niri-autoselect-portal.nixosModules.default
      niri.nixosModules.niri
      hyprland.nixosModules.default
      dank-material-shell.nixosModules.greeter
      dank-material-shell.nixosModules.dank-material-shell
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
      dms-plugin-registry.modules.default
      hermes-agent.nixosModules.default
      optnix.nixosModules.optnix
      surge.nixosModules.default
      # nyx-loner.nixosModules.default
      tlp-power-profile.nixosModules.default
      chaotic.nixosModules.default
      (import ./hosts/utkar/home-manager.nix {inherit inputs self system pkgs;})
    ];
  };

  # Standalone Home Manager output (for `home-manager switch`)
  flake.homeConfigurations."utkar@utkar" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = [
      ./home/utkar/home.nix
      ({pkgs, ...}: {nix.package = pkgs.nix;})
    ];
    extraSpecialArgs = {inherit inputs self system;};
  };
}
