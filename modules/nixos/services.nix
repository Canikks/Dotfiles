{
  pkgs,
  config,
  inputs,
  lib,
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
      extraDependencyGroups = ["hindsight" "messaging"];
      addToSystemPackages = true;
      extraPackages = with pkgs; [
        agent-browser
        #   curl
        #   google-chrome
        #   chromium
      ];
      restartSec = 5;
      container = {
        backend = "podman";
        hostUsers = ["utkar"];
        extraVolumes = [
          "/home/utkar/dotfiles:/dotfiles:rw"
        ];
      };
      settings = {
        auxiliary = {
          vision = {
            provider = "openrouter";
            base_url = "https://openrouter.ai/api/v1";
            model = "z-ai/glm-5.3-flash";
          };
          web_extract = {
            provider = "openrouter";
            base_url = "https://openrouter.ai/api/v1";
            model = "inception/mercury-2.5-preview";
          };
        };
        display = {
          compact = false;
          # personality = "kawaii";
        };
        compression = {
          enabled = true;
          threshold = 0.75;
          summary_model = "inception/mercury-2.5-preview";
        };
        memory = {
          memory_enabled = true;
          user_profile_enabled = true;
        };
        model = {
          base_url = "https://openrouter.ai/api/v1";
          default = "z-ai/glm-5.3-flash";
          provider = "openrouter";
        };
        terminal.backend = "local";
        toolsets = ["all"];
      };
    };
    searx = {
      enable = true;
      # domain = "utkar.local";
      # configureNginx = true;
      # configureUwsgi = true;
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
    cloudflare-warp = {
      enable = true;
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
      extraSetFlags = ["--advertise-exit-node"];
    };
    blocky = {
      enable = true;
      settings = {
        ports = {
          freeBind = true;
          dns = [
            "127.0.0.1:53"
            "100.108.9.38:53"
          ];
          http = 4000;
        };
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = ["1.1.1.1" "1.0.0.1"];
        };
        upstreams.strategy = "parallel_best";
        upstreams.groups.default = [
          "tcp-tls:dns.quad9.net:853"
          "https://dns.quad9.net/dns-query"
          "https://one.one.one.one/dns-query"
          "tcp-tls:cloudflare-dns.com:853"
          "https://freedns.controld.com/p0"
          "p0.freedns.controld.com"
        ];
        caching = {
          minTime = "2m";
          maxTime = "10m";
          prefetching = true;
          prefetchExpires = "10m";
          prefetchThreshold = 10;
        };
        blocking = {
          # allowlists = {
          #   nix-caches = [
          #     "us-central-1.telnyxstorage.com"
          #   ];
          # };
          loading.refreshPeriod = "4h";
          denylists = {
            ads = ["https://oisd.nl"];
            security = ["https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt"];
          };
          clientGroupsBlock = {
            default = ["ads"];
          };
        };
      };
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      reflector = true;
      publish.enable = true;
      publish.addresses = true;
      openFirewall = true;
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
    btrfs.autoScrub.enable = false;
    fstrim.enable = true;
    fwupd.enable = true;
    psd.enable = true;
    geoclue2.enable = true;
    upower.enable = true;
    thermald.enable = false;
    tlpPowerProfile.enable = true;

    # --- User & Desktop Services ---
    logind = {
      enable = true;
      settings.Login = {
        HandleLidSwitch = "ignore";
        KillUserProcesses = false;
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
      };
    };
    xserver.enable = true;
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
    playerctld.enable = true;
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
              pulse = {
                default = {req = "256/48000";};
                max = {
                  quantum = "256/48000";
                  req = "256/48000";
                };
                min = {
                  quantum = "256/48000";
                  req = "256/48000";
                };
              };
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
      enable = false;
      settings.dynamic_tuning = true;
    };
    tlp = {
      enable = true;
      pd.enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        ENERGY_PERF_POLICY_ON_AC = "performance";
        ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        INTEL_GPU_MIN_FREQ_ON_AC = 500;
        INTEL_GPU_MIN_FREQ_ON_BAT = 400;
        INTEL_GPU_MAX_FREQ_ON_AC = 1250;
        INTEL_GPU_MAX_FREQ_ON_BAT = 1250;
        INTEL_GPU_BOOST_FREQ_ON_AC = 1250;
        # TLP_DEFAULT_MODE = "AC";
      };
    };
    power-profiles-daemon.enable = false;

    # --- Others ---
    minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      managementSystem = {
        tmux.enable = true;
      };
      servers = {
        "Nixos" = {
          enable = true;
          autoStart = false;
          jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
          enableReload = true;
          package = pkgs.fabricServers.fabric-1_21_1;
          serverProperties = {
            server-port = 25565;
            difficulty = "normal";
            max-players = 20;
            motd = "NixOS Minecraft server!";
            white-list = false;
            enable-rcon = false;
            online-mode = false;
          };
        };
      };
    };
    # minecraft-server = {
    #   enable = true;
    #   package = pkgs.fabricServers.fabric-1_21_1;
    #   # package = with pkgs;
    #   #   nur.repos.toyvo.fabricServers.fabric-1_21_1.overrideAttrs (old: {
    #   #     installPhase = ''
    #   #       mkdir -p $out/bin $out/lib/minecraft
    #   #       cp -v $src $out/lib/minecraft/server.jar
    #   #
    #   #       cat > $out/bin/minecraft-server <<EOF
    #   #       #!${pkgs.bash}/bin/bash
    #   #       exec ${pkgs.temurin-jre-bin}/bin/java "\$@" \
    #   #         -jar $out/lib/minecraft/server.jar \
    #   #         nogui
    #   #       EOF
    #   #
    #   #       chmod +x $out/bin/minecraft-server
    #   #     '';
    #   #   });
    #   eula = true;
    #   openFirewall = true;
    #   jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
    #   # jvmOpts = "";
    #   serverProperties = {
    #     server-port = 25565;
    #     # difficulty = "normal";
    #     max-players = 20;
    #     motd = "NixOS Minecraft server!";
    #     white-list = false;
    #     enable-rcon = false;
    #     online-mode = false;
    #   };
    # };
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
      scheduler = "scx_flow";
      # extraArgs = ["-p gaming"];
    };
  };
}
