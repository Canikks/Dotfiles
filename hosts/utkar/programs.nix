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
    fish = {
      enable = true;
      useBabelfish = true;
    };
    zsh = {
      enable = true;
    };
    xonsh = {
      enable = false;
      package = pkgs.xonsh;
      extraPackages = ps: [
        pkgs.nur.repos.xonsh-xontribs.xontrib-fish-completer
        pkgs.nur.repos.xonsh-xontribs.xontrib-whole-word-jumping
        pkgs.nur.repos.xonsh-xontribs.xontrib-abbrevs
        pkgs.nur.repos.xonsh-xontribs.xontrib-term-integrations
      ];
      config = ''
        # --- Core Init ---
        $XONSH_SHOW_TRACEBACK = False
        $SUPPRESS_ACTIVATE_MESSAGE = True

        # Initialize tools efficiently
        execx($(starship init xonsh))
        execx($(zoxide init xonsh), 'exec')

        # --- Load Xontribs ---
        xontrib load fish_completer whole_word_jumping abbrevs

        # --- QoL Configuration ---
        $XONSH_HISTORY_BACKEND = 'json'
        $HISTCONTROL = 'ignoredups'
        $XONSH_AUTOPAIR = True
        $CASE_SENSITIVE_COMPLETIONS = False
        $FZF_WIDGETS_OPTS = {'height': '40%', 'layout': 'reverse', 'border': 'rounded'}

        # --- Aliases (Optimized) ---
        # Using a dictionary for batch updates is cleaner in Python/Xonsh!
        if $(which lsd):
            aliases.update({
                'tree': 'lsd --tree',
            })

        if $(which bat):
            aliases['cat'] = 'bat --style=plain'

        aliases.update({
            'grep': 'grep --color=auto',
            '..': 'cd ..',
            '...': 'cd ../..',
            'nls': 'nixos-cli generation list', # Added for your nixos-cli!
        })

        # --- Abbreviations ---
        abbrevs.update({
            'gco': 'git checkout',
            'gst': 'git status',
            'gp': 'git push',
            'gcm': 'git commit -m', # Extra sparkle!
            'gl': 'git log --oneline --graph --all', # Extra sparkle!
        })
      '';
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
            # For legacy systems
            # evaluator = "nix-instantiate --eval '<nixpkgs/nixos>' -A config.{{ .Option }}";
          };
          home-manager = {
            description = "home-manager options for all systems";
            options-list-file = optnixLib.hm.mkOptionsListFromHMSource {
              home-manager = inputs.home-manager;
              modules = with inputs; [
                nur.repos.moredhel.modules.homeManager
                nix-index-database.homeModules.nix-index
                dank-material-shell.homeModules.dank-material-shell
                dank-material-shell.homeModules.niri
                mango.hmModules.mango
                dsearch.homeModules.default
                nvf.homeManagerModules.default
                sops-nix.homeManagerModules.sops
                dms-plugin-registry.modules.default
                zen-browser.homeModules.beta
                noctalia.homeModules.default
                stylix.homeModules.stylix
                optnix.homeModules.optnix
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
      enableXonshIntegration = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
    };

    # --- Window Managers & Compositors ---
    niri = {
      enable = true;
      # package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
      package = pkgs.niri-unstable;
    };
    hyprland = {
      enable = false;
      # plugins = with pkgs; [
      #   hyprlandPlugins.hyprexpo
      # ];
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = false;
    };
    uwsm = {
      enable = true;
    };
    iio-hyprland = {
      enable = true;
    };

    # --- System & Utility Tools ---
    nixos-cli = {
      enable = true;
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
    mtr = {
      enable = true;
    };
    nix-index-database.comma.enable = true;
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

    # --- Gaming ---
    steam = {
      enable = true;
      package = pkgs.steam.override {
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
    };
    gamemode = {
      enable = true;
    };

    # --- Desktop & UI Enhancements ---
    dank-material-shell = {
      enable = false;
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
        clight.enable = false;
        catWidget.enable = true;
        wallpaperCarousel.enable = true;
        desktopCommand.enable = true;
        dankSystemDoctor.enable = true;
        aiAssistant.enable = true;
        screenRecorder.enable = true;
        usbManager.enable = true;
      };
      systemd = {
        enable = true;
        restartIfChanged = true;
        target = "niri.service";
      };
      # quickshell.package = inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
      quickshell.package = pkgs.quickshell;
      greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = "${config.users.users.utkar.home}";
        quickshell.package = pkgs.quickshell;
        # quickshell.package = inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
      };
    };
    kdeconnect = {
      enable = true;
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
