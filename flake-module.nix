{ self, inputs, lib, ... }:
let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in {
  flake.nixosConfigurations.utkar = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
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
      (import ./hosts/utkar/home-manager.nix { inherit inputs self system pkgs; })
    ];
  };
}