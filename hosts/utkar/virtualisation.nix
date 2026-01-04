{...}: {
  virtualisation = {
    libvirtd.enable = true;
    libvirtd.dbus.enable = true;
    libvirtd.qemu = {
      runAsRoot = true;
      swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
    containers = {
      enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
