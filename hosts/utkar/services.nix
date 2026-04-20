{
  pkgs,
  config,
  inputs,
  ...
}: {
  services = {
    # --- AI & Web Services ---
    hermes-agent = {
      enable = true;
      environmentFiles = [config.sops.secrets."hermes_env".path];
      user = "utkar";
      group = "users";
      createUser = false;
      stateDir = "${config.users.users.utkar.home}/hermes";
      workingDirectory = "${config.users.users.utkar.home}/dotfiles";
      addToSystemPackages = true;
      extraPackages = with pkgs; [
        agent-browser
        curl
        google-chrome
        chromium
      ];
      restartSec = 5;
      container = {
        backend = "podman";
        hostUsers = ["utkar"];
        extraVolumes = [
          "/home/user/dotfiles:/dotfiles:rw"
        ];
      };
      settings = {
        display = {
          compact = false;
          personality = "kawaii";
        };
        compression = {
          enabled = true;
          threshold = 0.75;
          sommary_model = "google/gemma-4-26b-a4b-it:free";
        };
        memory = {
          memory_enabled = true;
          user_profile_enabled = true;
        };
        model.provider = "openrouter";
        model.base_url = "https://openrouter.ai/api/v1";
        model.default = "google/gemma-4-31b-it:free";
        terminal.backend = "local";
        toolsets = ["all"];
      };
    };
    searx = {
      enable = true;
      # domain = "utkar.local";
      configureNginx = false;
      configureUwsgi = false;
      redisCreateLocally = true;
      # openFirewall = true;
      settings = {
        server.bind_address = "0.0.0.0";
        server.port = "8080";
        server.secret_key = "${builtins.readFile config.sops.secrets.searx_key.path}";
      };
    };
    open-webui = {
      enable = false;
      openFirewall = true;
      port = 11111;
      environment = {
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
        WEBUI_AUTH = "***";
      };
    };

    # --- Network & DNS ---
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
          "tcp-tls:dns.quad9.net:853"
          "https://one.one.one.one/dns-query"
          "2620:fe::fe"
          "2606:4700:4700::1111"
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
            ads = ["https://oisd.nl"];
            security = ["https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt"];
          };
          clientGroupsBlock = {
            default = ["ads" "security"];
          };
        };
      };
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      reflector = true;
      publish.enable = true;
    };
    resolved = {
      enable = false;
      settings.Resolve = {
        DNSOverTLS = true;
        Domains = ["~."];
        FallbackDNS = ["1.1.1.1#cloudflare-dns.com"];
      };
    };
    openssh.enable = true;

    # --- System Maintenance & Hardware ---
    zram-generator.enable = true;
    systemd-lock-handler.enable = true;
    btrfs.autoScrub.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    psd.enable = true;
    geoclue2.enable = true;
    upower.enable = true;
    thermald.enable = false;

    # --- User & Desktop Services ---
    xserver.enable = false;
    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
      wayland.compositor = "kwin";
      theme = "sddm";
      extraPackages = with pkgs; [
        qt6.qtdeclarative
        qt6.qt5compat
        qt6.qtbase
        qt6.qtmultimedia
        # qt5.qtbase
      ];
      settings = {
        General = {
          GreeterEnvironment = "XCURSOR_THEME=DMZ-White,XCURSOR_SIZE=24";
        };
      };
    };
    noctalia-shell = {
      enable = false;
      target = "niri.service";
    };
    homed.enable = true;
    gvfs.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    dbus = {
      enable = true;
      implementation = "broker";
    };
    flatpak.enable = true;
    tumbler.enable = true;
    envfs = {
      enable = true;
      extraFallbackPathCommands = "ln -s $''{pkgs.bash}/bin/bash $out/bash";
    };
    userborn.enable = true;
    clight.enable = false;

    # --- Audio & Multimedia ---
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
      audio.enable = true;
      raopOpenFirewall = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # --- Power & Thermal Management ---
    tuned = {
      enable = true;
      settings.dynamic_tuning = true;
    };
    tlp = {
      enable = false;
      pd.enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        ENERGY_PERF_POLICY_ON_AC = "performance";
        ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        TLP_DEFAULT_MODE = "AC";
      };
    };
    power-profiles-daemon.enable = false;

    # --- Others ---
    niri-autoselect-portal.enable = true;
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
      daemon.enable = false;
      fangfrisch.enable = false;
      updater.enable = false;
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
    # nirinit = {
    #   enable = false;
    #   package = inputs.nirinit.packages.${pkgs.stdenv.hostPlatform.system}.default;
    #   settings.launch = {
    #     "zen" = "zen-beta";
    #     "com.mitchellh.ghostty" = "ghostty";
    #   };
    # };
    scx = {
      enable = true;
      scheduler = "scx_cake";
      extraArgs = ["-p gaming"];
    };
  };
}
