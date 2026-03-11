{pkgs, ...}: {
  virtualisation = {
    libvirtd.enable = true;
    libvirtd.dbus.enable = true;
    libvirtd.qemu = {
      runAsRoot = true;
      swtpm.enable = true;
      package = pkgs.qemu_kvm;
      vhostUserPackages = [pkgs.virtiofsd];
    };
    vmware.host.enable = false;
    vmware.guest.enable = false;
    hypervGuest.enable = true;
    spiceUSBRedirection.enable = true;
    containers = {
      enable = true;
    };
    docker = {
      enable = true;
    };
    podman = {
      enable = true;
      # dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
