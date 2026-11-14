{
  pkgs,
  inputs,
  ...
}: {
  # system.etc.overlay.enable = true;
  boot = {
    # --- Boot Loader Configuration ---
    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        style = {
          wallpapers = ["/home/utkar/Pictures/Wallpapers/asuras-wrath-28382-1920x1080.jpg"];
        };
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };

    # --- Kernel & Initrd ---
    plymouth = {
      enable = true;
      theme = "nixos";
      themePackages = [inputs.nixos-plymouth-theme.packages.${pkgs.stdenv.hostPlatform.system}.default];
    };
    tmp = {
      tmpfsHugeMemoryPages = "within_size";
      useTmpfs = true;
      cleanOnBoot = true;
    };
    # initrd.systemd.enable = true;
    initrd.systemd.dbus.enable = true;
    resumeDevice = "/dev/disk/by-label/nix-swap";
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "tcp_bbr"
    ];
    # kernelPatches = [
    #   {
    #     name = "Rust Support";
    #     patch = null;
    #     features = {
    #       rust = true;
    #     };
    #   }
    # ];
    kernelParams = [
      # "i915.enable_guc=3"
      "i915.force_probe=!9a78"
      "xe.force_probe=9a78"
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.zpool=zsmalloc"
      "zswap.max_pool_percent=35"
      "zswap.shrinker_enabled=1"
      "cfg80211.ieee80211_regdom=IN"
    ];

    # --- Kernel Tuning & Sysctl ---
    kernel = {
      sysfs = {
        devices.system.cpu.intel_pstate.hwp_dynamic_boost = true;
      };
      sysctl = {
        # "net.ipv4.ip_forward" = 1;
        # "net.ipv6.conf.all.forwarding" = 1;
        "vm.watermark_scale_factor" = 100;
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.wmem_max" = 33554432;
        "net.core.rmem_max" = 33554432;
        "net.ipv4.tcp_rmem" = "4096 87380 33554432";
        "net.ipv4.tcp_wmem" = "4096 87380 33554432";
        "dev.tty.ldisc_autoload" = 0;
        "vm.swappiness" = 150;
        "vm.vfs_cache_pressure" = 50;
        # "vm.watermark_scale_factor" = 125;
        "vm.dirty_ratio" = 10;
        "net.ipv4.ip_unprivileged_port_start" = 80;
        "vm.dirty_background_ratio" = 5;
        "vm.defrag_mode" = 0;
        "vm.compaction_proactiveness" = 20;
        "vm.page-cluster" = 0;
      };
    };
  };
}
