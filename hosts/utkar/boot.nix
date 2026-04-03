{pkgs, ...}: {
  boot = {
    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        style = {
          wallpapers = ["/home/utkar/Pictures/Wallpapers/Dark-Waves/P13.png"];
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
    resumeDevice = "/dev/disk/by-label/nix-swap";
    kernelPatches = [
      {
        name = "Rust Support";
        patch = null;
        features = {
          rust = true;
        };
      }
    ];
    kernelParams = [
      "i915.enable_guc=3"
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.zpool=zsmalloc"
      "zswap.max_pool_percent=20"
      "cfg80211.ieee80211_regdom=IN"
    ];
    kernelPackages = pkgs.linuxPackages_xanmod_stable;
    kernelModules = [
      "tcp_bbr"
    ];
    kernel = {
      sysfs = {
        devices.system.cpu.intel_pstate.hwp_dynamic_boost = true;
      };
      sysctl = {
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.wmem_max" = 1073741824;
        "net.core.rmem_max" = 1073741824;
        "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
        "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
        "dev.tty.ldisc_autoload" = 0;
        "vm.swappiness" = 60;
        "vm.vfs_cache_pressure" = 50;
        "vm.watermark_scale_factor" = 125;
        "vm.dirty_ratio" = 10;
        "vm.dirty_background_ratio" = 5;
      };
    };
  };
}
