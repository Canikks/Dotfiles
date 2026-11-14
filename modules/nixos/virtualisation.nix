{
  pkgs,
  config,
  ...
}: {
  virtualisation = {
    # --- Libvirtd & QEMU & Waydroid ---
    libvirtd = {
      enable = true;
      # firewallBackend =
      #   if config.networking.nftables.enable
      #   then "nftables"
      #   else "iptables";
      dbus.enable = true;
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
        package = pkgs.qemu_kvm;
        vhostUserPackages = [pkgs.virtiofsd];
        verbatimConfig = ''
          seccomp_sandbox = 0
        '';
      };
    };
    waydroid.enable = false;

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
    docker.enable = true;
    podman = {
      enable = true;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
