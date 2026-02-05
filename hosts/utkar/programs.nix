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

    xonsh = {
      enable = true;

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
