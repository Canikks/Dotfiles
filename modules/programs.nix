{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs = {
    virt-manager.enable = true;

    nix-index-database.comma.enable = true;

    dankMaterialShell = {
      enable = true;
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableClipboard = true; # Clipboard history manager
      enableVPN = true; # VPN management widget
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = false; # Calendar integration (khal)
      # enableSystemSound = true; # System sound effects
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
      flake = "home/utkar/Dotfiles";
    };

    bat = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
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

    television = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
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
