{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs = {
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
        use_nvd = true;
        apply = {
          reexec_as_root = true;
          use_git_commit_msg = true;
          imply_impure_with_tag = true;
          ignore_dirty_tree = true;
          use_nom = true;
        };
      };
    };

    kdeconnect = {
      enable = true;
    };

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

    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
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
      enableClipboardPaste = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
      greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = "/home/utkar";
        quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };

    # mango = {
    #   enable = true;
    # };

    dconf = {
      enable = true;
    };

    bat = {
      enable = false;
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

    iio-hyprland = {
      enable = true;
    };

    hyprland = {
      enable = true;
      withUWSM = true;
    };

    niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    };

    xonsh = {
      enable = false;

      package = pkgs.xonsh;
      extraPackages = ps: [
        pkgs.nur.repos.xonsh-xontribs.xontrib-fish-completer # Best-in-class completions
        pkgs.nur.repos.xonsh-xontribs.xontrib-whole-word-jumping # Natural text navigation
        pkgs.nur.repos.xonsh-xontribs.xontrib-abbrevs # Expand-as-you-type abbreviations
        pkgs.python313Packages.prompt-toolkit
      ];

      config = ''
        # --- Core Init ---
        # Suppress the welcome message
        $XONSH_SHOW_TRACEBACK = False
        $SUPPRESS_ACTIVATE_MESSAGE = True

        # Initialize Starship Prompt
        execx($(starship init xonsh))

        # Initialize Zoxide (Smarter cd)
        execx($(zoxide init xonsh), 'exec')

        # --- Load Xontribs ---
        # Note: 'fish_completer' needs fish installed in systemPackages
        xontrib load fish_completer whole_word_jumping abbrevs

        # --- QoL Configuration ---
        # Better history management
        $XONSH_HISTORY_BACKEND = 'json'
        $HISTCONTROL = 'ignoredups'

        # Auto-pair brackets/quotes
        $XONSH_AUTOPAIR = True

        # Case-insensitive tab completion
        $CASE_SENSITIVE_COMPLETIONS = False

        # FZF Widgets Configuration (optional tweaks)
        $FZF_WIDGETS_OPTS = {'height': '40%', 'layout': 'reverse', 'border': 'rounded'}

        # --- Aliases ---
        # Use common modern replacements if they exist
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

        # NixOS Specific Aliases
        aliases['nrs'] = 'sudo nixos-rebuild switch'
        aliases['nfu'] = 'nix flake update'
        aliases['ncg'] = 'sudo nix-collect-garbage -d'

        # --- Abbreviations (expands space) ---
        # Requires xontrib-abbrevs
        abbrevs['gco'] = 'git checkout'
        abbrevs['gst'] = 'git status'
        abbrevs['gp'] = 'git push'
      '';
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
      enableFishIntegration = true;
      enableXonshIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };

    uwsm = {
      enable = true;
      # waylandCompositors = {
      #   mangowc = {
      #     prettyName = "Mango";
      #     comment = "Mango compositor managed by UWSM";
      #     binPath = "/run/current-system/sw/bin/mango";
      #   };
      # };
    };

    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraArgs = "-system-composer";
      };
      extest.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        nur.repos.forkprince.proton-cachyos-v2-bin
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
  };
}
