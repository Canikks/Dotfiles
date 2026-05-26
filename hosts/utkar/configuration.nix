{ ... }: {
  imports = [
    ../../modules/nixos/locale.nix
    ../../modules/nixos/appearance.nix
    ../../modules/nixos/portals.nix
    ../../modules/nixos/secrets.nix
    ../../modules/nixos/security.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/programs.nix
    ../../modules/nixos/services.nix
    ../../modules/nixos/environment.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/hardware.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/virtualisation.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/systemd.nix
    ./hardware-configuration.nix
  ];
}