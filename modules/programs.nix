{pkgs, ...}: {
  programs = {
    java = {
      enable = true;
      binfmt = true;
    };

    virt-manager.enable = true;

    nix-index-database.comma.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        gcc.cc.lib
        glibc
        libmd
        libz
        gccNGPackages_15.libstdcxx
        icu
        libc
      ];
    };

    dank-material-shell = {
      enable = true;
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = true; # VPN management widget
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = false; # Calendar integration (khal)
      systemd = {
        enable = true; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
      };
      greeter = {
        enable = true;
        compositor.name = "niri"; # or set to hyprland
        configHome = "/home/utkar"; # optionally copyies that users DMS settings (and wallpaper if set) to the greeters data directory as root before greeter starts
      };
    };

    mango = {
      enable = true;
    };

    dconf = {
      enable = true;
    };

    xwayland = {
      enable = true;
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 3";
        dates = "daily";
      };
      flake = "home/utkar/dotfiles";
    };

    bat = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    git = {
      enable = true;
      lfs = {
        enable = true;
      };
    };

    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    # television = {
    #   enable = true;
    #   # enableZshIntegration = true;
    #   # enableFishIntegration = true;
    # };

    fish = {
      enable = true;
      useBabelfish = true;
    };

    zsh = {
      enable = true;
    };

    direnv = {
      enable = true;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
        waylandCompositors = {
          prettyName = "Mango";
          comment = "Mango compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/mango";
        };
      };
    };

    steam = {
      enable = true;
      extest.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    gamescope = {
      enable = true;
    };

    gamemode = {
      enable = true;
    };
  };
}
