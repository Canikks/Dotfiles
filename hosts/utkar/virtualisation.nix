{...}: {
  virtualisation = {
    libvirtd.enable = false;
    libvirtd.dbus.enable = true;
    libvirtd.qemu = {
      runAsRoot = true;
      swtpm.enable = true;
    };
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
