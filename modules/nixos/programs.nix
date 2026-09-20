{
  pkgs,
  options,
  inputs,
  config,
  ...
}: let
  optnixLib = inputs.optnix.mkLib pkgs;
in {
  programs = {
    # --- Shells & Terminal ---
    ccache.enable = false;
    fish = {
      enable = true;
      useBabelfish = true;
    };
    zsh = {
      enable = true;
    };
    nushell = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
    optnix = {
      enable = true;
      settings = {
        scopes = {
          utkar = {
            description = "nixos configuration for me";
            options-list-file = optnixLib.mkOptionsList {inherit options;};
            # For flake systems
            evaluator = "nix eval ${config.users.users.utkar.home}/dotfiles#nixosConfigurations.utkar.config.{{ .Option }}";
          };
          home-manager = {
            description = "home-manager options for all systems";
            options-list-file = optnixLib.hm.mkOptionsListFromHMSource {
              home-manager = inputs.home-manager;
              modules = with inputs; [
                nur.repos.moredhel.modules.homeManager
                nix-index-database.homeModules.nix-index
                dms.homeModules.dank-material-shell
                dms.homeModules.niri
                mango.hmModules.mango
                dux-search.homeModules.default
                nvf.homeManagerModules.default
                sops-nix.homeManagerModules.sops
                dux-plugin-registry.homeModules.default
                zen-browser.homeModules.twilight
                # noctalia.homeModules.default
                stylix.homeModules.stylix
                optnix.homeModules.optnix
                yazelix-hm.homeManagerModules.default
                chaotic.homeManagerModules.default
                fetch.homeManagerModules.default
                umbriel.homeModules.default
              ];
            };
          };
        };
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableXonshIntegration = true;
    };
    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableXonshIntegration = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
      prompt.enable = true;
    };
    nvf = {
      enable = true;
    };

    # --- Window Managers & Compositors ---
    niri = {
      enable = true;
      # package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
      package = pkgs.niri-unstable;
    };
    mango = {
      enable = false;
    };
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };
    umbriel.enable = true;
    uwsm = {
      enable = true;
    };
    iio-hyprland = {
      enable = true;
    };

    # --- System & Utility Tools ---
    qtengine = {
      enable = false;
      config = {
        theme = {
          style = "oxygen";
          colorScheme = "${config.users.users.utkar.home}/.local/share/color-schemes/DankMatugen.colors";
        };
        misc = {
          singleClickActivate = true;
          menusHaveIcons = true;
          shortcutsForContextMenus = true;
        };
      };
    };
    nh = {
      enable = true;
      flake = "${config.users.users.utkar.home}/dotfiles";
    };
    less = {
      enable = true;
    };
    nixos-cli = {
      enable = false;
      option-cache.enable = true;
      activation-interface.enable = true;
      settings = {
        aliases = {
          genlist = ["generation" "list"];
          switch = ["generation" "switch"];
          rollback = ["generation" "rollback"];
        };
        config_location = "${config.users.users.utkar.home}/dotfiles";
        differ = {
          tool = "command";
          command = ["dix" "-v"];
        };
        apply = {
          reexec_as_root = true;
          use_git_commit_msg = true;
          imply_impure_with_tag = true;
          ignore_dirty_tree = true;
          use_nom = true;
        };
      };
    };
    partition-manager = {
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
      # package = pkgs.jdk17;
      enable = true;
      binfmt = true;
    };
    mtr = {
      enable = true;
    };
    nix-index-database = {
      comma.enable = true;
      enable = true;
    };
    nix-index.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        gcc.cc.lib
        glibc
        libmd
        libz
        icu
        libc
        qt5.qtbase
        qt5.qtwayland
        openal
      ];
    };
    dconf = {
      enable = true;
    };
    bat = {
      enable = false;
    };
    surge = {
      enable = true;
      systemd.enable = true;
    };

    # --- Gaming ---
    steam = {
      enable = true;
      package = pkgs.millennium-steam.override {
        extraArgs = "-system-composer";
      };
      extest.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        nur.repos.vladexa.proton-cachyos-v3
      ];
      extraPackages = with pkgs; [
        gamescope
        umu-launcher
      ];
    };
    gamescope = {
      enable = true;
      package = pkgs.gamescope_git;
    };
    gamemode = {
      enable = true;
    };

    # --- Desktop & UI Enhancements ---
    noctalia = {
      enable = true;
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
      systemd = {
        enable = true;
        target = "umbriel-session.target";
      };
    };
    noctalia-greeter = {
      enable = false;
      package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
      passwordless-sync-users = ["utkar"];
    };
    ambxst.enable = false;
    dux-files = {
      enable = true;
      package = inputs.dux-files.packages.${pkgs.stdenv.hostPlatform.system}.default;
      portal.enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
    dank-material-shell = {
      enable = true;
      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = false;
      enableClipboardPaste = true;
      plugins = {
        dockerManager.enable = true;
        mediaPlayer.enable = true;
        commandRunner.enable = true;
        dankLauncherKeys.enable = true;
        easyEffects.enable = true;
        niriWindows.enable = true;
        webSearch.enable = true;
        dankDesktopWeather.enable = true;
        dankKDEConnect.enable = true;
        nixMonitor.enable = true;
        dankClight.enable = true;
        dankNotepadModule.enable = true;
        catWidget.enable = true;
        wallpaperCarousel.enable = true;
        desktopCommand.enable = true;
        dankSystemDoctor.enable = true;
        aiAssistant.enable = true;
        screenCaptureToolbar.enable = true;
        usbManager.enable = true;
        ocrScanner.enable = true;
        bongoCat.enable = true;
        nixPackageRunner.enable = true;
        mediaControlPlus.enable = true;
        dankMenu.enable = true;
        dms-common = {
          src = pkgs.fetchFromGitHub {
            owner = "hthienloc";
            repo = "dms-common";
            rev = "daf201f3d22584ba01931a763d7dbf05811349f7";
            sha256 = "sha256-nLY1oeSOocma2dOWMfU9Yz+wAFHYSg4MyZpjSi4I+pg=";
          };
        };
        dmsThemeSync.enable = true;
        lutrisLauncher.enable = true;
        tlpPowerProfile.enable = true;
        clipboardPlus.enable = true;
        systemMonitorPlus.enable = true;
        dankVault.enable = true;
        dmsfilemanager.enable = true;
        dmsconky.enable = true;
        hyprlandSubmapIndicator.enable = true;
        theGrove.enable = true;
        intelGpuMonitor.enable = true;
        # intelGpuMonitor.src = pkgs.fetchFromGitHub {
        #   owner = "rdannenbring";
        #   repo = "dms-intel-gpu-plugin";
        #   rev = "3a37dfe51aa43abf08df9f5bf481d10f1691d1a2";
        #   sha256 = "sha256-BIwmn8vYccPuZteOEbZNQlLCtm5sol2C15j319c4pPk=";
        # };
      };
      systemd = {
        enable = true;
        restartIfChanged = true;
        target = "niri.service";
      };
      # quickshell.package = inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
      # quickshell.package = pkgs.quickshell;
    };
    dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "${config.users.users.utkar.home}";
      compositor.customConfig = ''
        hotkey-overlay {
            skip-at-startup
        }

        environment {
            DMS_RUN_GREETER "1"
        }

        gestures {
          hot-corners {
            off
          }
        }

        layout {
          background-color "#000000"
        }
      '';
      # quickshell.package = pkgs.quickshell;
      # quickshell.package = inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    };
    dank-calendar = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
    kdeconnect = {
      enable = true;
      # package = pkgs.valent;
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
    gpu-screen-recorder = {
      enable = true;
    };
    localsend = {
      enable = true;
      openFirewall = true;
    };
    virt-manager.enable = true;
  };
}
