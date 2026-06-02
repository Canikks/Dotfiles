{self, ...}: {
  imports = with self.nixosModules; [
    locale
    appearance
    portals
    secrets
    security
    users
    packages
    programs
    services
    environment
    network
    hardware
    boot
    virtualisation
    nix
    systemd
    (import ./hardware-configuration.nix)
  ];
}
