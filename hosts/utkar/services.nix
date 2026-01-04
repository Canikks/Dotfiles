{pkgs, ...}: {
  services = {
    flatpak = {
      enable = true;
    };

    pihole-ftl = {
      enable = false;
      settings = {
        dns.upstreams = [
          "9.9.9.9"
          "149.112.112.112"
          "2620:fe::fe"
          "2620:fe::9"
        ];
        # dns.listeningMode = "all";
      };
    };

    pihole-web = {
      enable = false;
      ports = [
        "80r"
      ];
    };

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

        # CRITICAL FIX: Bootstrap DNS
        # Blocky uses these specific IPs to resolve the DoH upstreams below.
        # Without this, Blocky cannot start because it can't resolve "dns.quad9.net".
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = ["1.1.1.1" "1.0.0.1"];
        };

        # Encrypted Upstreams (DoH)
        upstreams.groups.default = [
          "https://dns.quad9.net/dns-query"
          "https://dns.mullvad.net/dns-query"
        ];

        # Performance: Prefetching
        caching = {
          minTime = "5m";
          maxTime = "30m";
          prefetching = true;
          prefetchExpires = "2h";
          prefetchThreshold = 5;
        };

        # Blocklists
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
      # extraConfig = ''
      #   DNSStubListener=no
      # '';
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
