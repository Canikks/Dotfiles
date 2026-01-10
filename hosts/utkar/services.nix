{pkgs, ...}: {
  services = {
    openssh.enable = true;

    flatpak = {
      enable = true;
    };

    # nixos-cli = {
    #   enable = true;
    #   prebuildOptionCache = true;
    #   useActivationInterface = true;
    #   config = {
    #     aliases = {
    #       genlist = ["generation" "list"];
    #       switch = ["generation" "switch"];
    #       rollback = ["generation" "rollback"];
    #     };
    #     use_nvd = true;
    #     apply = {
    #       use_nom = true;
    #     };
    #   };
    # };

    aria2 = {
      enable = true;
      rpcSecretFile = "/home/utkar/dotfiles/secrets/secret-rpc.txt";
      settings = {
        enable-rpc = true;
        dir = "/home/utkar/Downloads";
        openPorts = true;
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
          "https://dns.mullvad.net/dns-query"
        ];

        caching = {
          minTime = "5m";
          maxTime = "30m";
          prefetching = true;
          prefetchExpires = "2h";
          prefetchThreshold = 5;
        };

        blocking = {
          refreshPeriod = "4h";
          blackLists = {
            ads = [
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
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
    resolved = {
      enable = false;
      dnsovertls = "true";
      domains = ["~."];
      fallbackDns = ["1.1.1.1#cloudflare-dns.com"];
    };

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
