{
  config,
  pkgs,
  lib,
  ...
}: {
  # Common reusable configuration for all systems (useful if you ever add another host)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs = {
    virt-manager.enable = true;
    nix-index-database.comma.enable = true;
    dankMaterialShell.greeter = {
      enable = true;
      compositor.name = "niri"; # or set to hyprland
      configHome = "/home/utkar"; # optionally copyies that users DMS settings (and wallpaper if set) to the greeters data directory as root before greeter starts
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
      };
      flake = "home/utkar/dotfiles#utkar";
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
    };
    gamescope = {
      enable = true;
      package = pkgs.gamescope_git;
    };
    gamemode = {
      enable = true;
    };
  };

  services.flatpak.enable = true;
  # services.udisks2.enable = true;
}
