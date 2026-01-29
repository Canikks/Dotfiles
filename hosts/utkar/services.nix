{pkgs, ...}: {
  services = {
    openssh.enable = true;

    flatpak = {
      enable = true;
    };

    nirinit = {
      enable = true;
      settings = {
        launch = {
          "com.mitchellh.ghostty" = "ghostty";
          "zen-twilight" = "zen";
        };
      };
    };

    tumbler.enable = true;

    fstrim.enable = true;

    nixos-cli = {
      enable = true;
      prebuildOptionCache = true;
      useActivationInterface = true;
      config = {
        aliases = {
          genlist = ["generation" "list"];
          switch = ["generation" "switch"];
          rollback = ["generation" "rollback"];
        };
        config_location = "/home/utkar/dotfiles";
        use_nvd = true;
        apply = {
          use_nom = true;
        };
      };
    };

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
          dns = 53;
          http = 4000;
        };

        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = ["1.1.1.1" "1.0.0.1"];
        };

        upstreams.groups.default = [
          "https://dns.quad9.net/dns-query"
        ];

        caching = {
          minTime = "10m";
          maxTime = "1h";
          prefetching = true;
          prefetchExpires = "1h";
          prefetchThreshold = 10;
        };

        blocking = {
          refreshPeriod = "4h";
          blackLists = {
            ads = [
              "https://big.oisd.nl"
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
          "/home/utkar/Downloads"
          "/tmp"
          "/var/lib"
          "/var/tmp"
        ];
      };
      daemon = {
        enable = false;
      };
      fangfrisch = {
        enable = true;
      };
      updater = {
        enable = true;
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

    # resolved = {
    #   enable = false;
    #   dnsovertls = "true";
    #   domains = ["~."];
    #   fallbackDns = ["1.1.1.1#cloudflare-dns.com"];
    # };

    gvfs = {
      enable = true;
    };

    udisks2 = {
      enable = true;
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
      scheduler = "scx_lavd";
      extraArgs = [
        "--autopilot"
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
      enable = true;
    };

    tlp = {
      enable = false;
    };

    power-profiles-daemon = {
      enable = true;
    };
  };
}
