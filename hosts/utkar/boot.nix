{pkgs, ...}: {
  boot = {
    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        style = {
          wallpapers = [../../Pictures/maxresdefault.jpg];
        };
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = {
      bcachefs = true;
    };
    initrd.systemd.enable = true;
    initrd.systemd.dbus.enable = true;
    resumeDevice = "/dev/disk/by-uuid/539e1e37-72a1-47b4-add9-d4eb2cc6c398";
    kernelParams = ["resume_offset=13223936"];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [
      "tcp_bbr"
    ];
    kernel = {
      sysctl = {
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.wmem_max" = 1073741824;
        "net.core.rmem_max" = 1073741824;
        "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
        "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
        "dev.tty.ldisc_autoload" = 0;
      };
    };
  };
}
