{
  pkgs,
  inputs,
  config,
  ...
}: {
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
        pkgs.python313Packages.prompt-toolkit
      ];
      config = ''
        # --- Core Init ---
        $XONSH_SHOW_TRACEBACK = False
        $SUPPRESS_ACTIVATE_MESSAGE = True
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

        # --- Aliases ---
        if $(which eza):
            aliases['ls'] = 'eza --icons --git --group-directories-first'
            aliases['ll'] = 'eza -l --icons --git --group-directories-first'
            aliases['la'] = 'eza -la --icons --git --group-directories-first'
            aliases['tree'] = 'eza --tree --icons'

        if $(which bat):
            aliases['cat'] = 'bat --style=plain'

        aliases['grep'] = 'grep --color=auto'
        aliases['..'] = 'cd ..'
        aliases['...'] = 'cd ../..'
        aliases['nrs'] = 'sudo nixos-rebuild switch'
        aliases['nfu'] = 'nix flake update'
        aliases['ncg'] = 'sudo nix-collect-garbage -d'

        # --- Abbreviations ---
        abbrevs['gco'] = 'git checkout'
        abbrevs['gst'] = 'git status'
        abbrevs['gp'] = 'git push'
      '';
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
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
