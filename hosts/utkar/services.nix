{
  pkgs,
  config,
  inputs,
  ...
}: {
  services = {
    zram-generator.enable = true;

    systemd-lock-handler.enable = true;

    homed = {
      enable = true;
    };

    aria2 = {
      enable = false;
      serviceUMask = "0002";
      rpcSecretFile = "${config.users.users.utkar.home}/aria2.txt";
      settings = {
        max-connection-per-server = 16;
        split = 16;
        min-split-size = "4M";
        file-allocation = "falloc";
        console-log-level = "error";
        summary-interval = 0;
        show-console-readout = false;
        dir = "${config.users.users.utkar.home}/Downloads";
      };
    };

    envfs = {
      enable = true;
      extraFallbackPathCommands = "ln -s $''{pkgs.bash}/bin/bash $out/bash";
    };

    userborn = {
      enable = true;
    };

    clight = {
      enable = false;
    };

    btrfs.autoScrub.enable = true;

    openssh.enable = true;

    flatpak = {
      enable = true;
    };

    nirinit = {
      enable = false;
      package = inputs.nirinit.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        launch = {
          "zen" = "zen-beta";
          "com.mitchellh.ghostty" = "ghostty";
        };
      };
    };

    tumbler.enable = true;

    fstrim.enable = true;

    avahi = {
      enable = true;
      reflector = true;
      publish = {
        enable = true;
      };
    };

    blocky = {
      enable = true;
      settings = {
        ports = {
          dns = ["127.0.0.1:53"];
          http = 4000;
        };

        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = ["1.1.1.1" "1.0.0.1"];
        };

        upstreams.groups.default = [
          "https://dns.quad9.net/dns-query"
          "https://one.one.one.one/dns-query"
        ];

        caching = {
          minTime = "10m";
          maxTime = "1h";
          prefetching = true;
          prefetchExpires = "1h";
          prefetchThreshold = 10;
        };

        blocking = {
          loading.refreshPeriod = "4h";
          denylists = {
            ads = [
              "https://oisd.nl"
            ];
            security = [
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt"
            ];
          };
          clientGroupsBlock = {
            default = ["ads" "security"];
          };
        };
      };
    };

    spice-vdagentd.enable = true;

    clamav = {
      scanner = {
        enable = false;
        scanDirectories = [
          "${config.users.users.utkar.home}/Downloads"
          "/tmp"
          "/var/lib"
          "/var/tmp"
        ];
      };
      daemon = {
        enable = false;
      };
      fangfrisch = {
        enable = false;
      };
      updater = {
        enable = false;
      };
    };

    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [
        "intel"
        "modesetting"
      ];
    };

    resolved = {
      enable = false;
      settings.Resolve = {
        DNSOverTLS = true;
        Domains = ["~."];
        FallbackDNS = ["1.1.1.1#cloudflare-dns.com"];
      };
    };

    gvfs = {
      enable = true;
    };

    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };

    dbus = {
      enable = true;
      implementation = "broker";
    };

    pipewire = {
      enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "256/48000";
              pulse.default.req = "256/48000";
              pulse.max.req = "256/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "256/48000";
            };
          }
        ];
      };
      wireplumber = {
        enable = true;
        extraLv2Packages = with pkgs; [
          lsp-plugins
          zam-plugins
          calf
          mda_lv2
        ];
      };
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    scx = {
      enable = true;
      scheduler = "scx_cake";
      extraArgs = [
        "-p gaming"
      ];
    };

    fwupd = {
      enable = true;
    };

    psd = {
      enable = true;
    };

    geoclue2 = {
      enable = true;
    };

    upower = {
      enable = true;
    };

    thermald = {
      enable = false;
    };

    tuned = {
      enable = true;
      settings = {
        dynamic_tuning = true;
      };
      # ppdSettings = {
      #   main.default = "performance";
      # };
    };

    tlp = {
      enable = false;
      pd.enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        # CPU_BOOST_ON_BAT = 1;

        # IMPORTANT: ensure TLP re-evaluates power source
        # RESTORE_DEVICE_STATE_ON_STARTUP = 1;

        # Optional but recommended
        ENERGY_PERF_POLICY_ON_AC = "performance";
        ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        TLP_DEFAULT_MODE = "AC";
        # DEVICES_TO_DISABLE_ON_STARTUP = "";
      };
    };

    power-profiles-daemon = {
      enable = false;
    };
  };
}
