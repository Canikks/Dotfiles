{pkgs, ...}: {
  virtualisation = {
    # --- Libvirtd & QEMU & Waydroid ---
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
    waydroid.enable = true;

    # --- Guest Support ---
    vmware = {
      guest = {
        enable = false;
      };
      host = {
        enable = false;
      };
    };
    hypervGuest.enable = true;
    spiceUSBRedirection.enable = true;

    # --- Containers ---
    containers.enable = true;
    docker.enable = false;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
