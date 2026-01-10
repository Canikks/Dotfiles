{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    mtr = {
      enable = true;
    };

    gnupg = {
      dirmngr.enable = true;
      agent = {
        enable = true;
        enableSSHSupport = true;
        enableBrowserSocket = true;
        enableExtraSocket = true;
      };
    };

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
      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = false;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
      greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = "/home/utkar";
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
      flake = "~/dotfiles";
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
        mangowc = {
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
