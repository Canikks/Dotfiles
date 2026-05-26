{pkgs, ...}: {
  virtualisation = {
    # --- Libvirtd & QEMU ---
    libvirtd = {
      enable = true;
      dbus.enable = true;
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
        package = pkgs.qemu_kvm;
        vhostUserPackages = [pkgs.virtiofsd];
      };
    };

    # --- Guest Support ---
    vmware.host.enable = false;
    vmware.guest.enable = false;
    hypervGuest.enable = true;
    spiceUSBRedirection.enable = true;

    # --- Containers ---
    containers.enable = true;
    docker.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
