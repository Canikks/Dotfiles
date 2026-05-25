{
  lib,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = false;
    syntaxHighlighting.enable = false;
    autosuggestion.enable = false;
    zprof.enable = false;

    history.size = 10000;
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "HIST_IGNORE_SPACE"
      "NOMATCH"
    ];

    # sessionVariables = {
    #   MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    #   MANROFFOPT = "-c";
    # };

    shellAliases = {
      gs = "git status -u";
      cat = "bat";
      man = "batman";
      bg = "batgrep";
      diff = "batdiff";
      # rg = "rg --hyperlink-format=kitty";
      gpra = "git pull --rebase --autostash";
      df = "duf";
      curl = "curlie";
      cp = "xcp";
      rm = "trash";
    };

    initContent = let
      zshEarly = lib.mkOrder 500 ''
        # Fish-like speed optimizations ⚡
        zstyle ':zephyr:plugin:completion' 'use-cache' 'yes'
        zstyle ':zephyr:plugin:completion' 'use-xdg-basedirs' 'yes'
        zstyle ':zephyr:plugin:completion' 'compstyle' 'zephyr'
        ZSH_AUTOSUGGEST_USE_ASYNC=1
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

        # Completion Enhancements 🌈
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive completion
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':completion:*' group-name              # Group completions
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
        zstyle ':fzf-tab:*' switch-group '<' '>'

        alias -s {md,txt,json,yaml,toml,xml,conf,ini,log}=bat
        zstyle ':zephyr:plugin:editor' dot-expansion yes
        zstyle ':zephyr:plugin:editor' magic-enter yes
        zstyle ':zephyr:plugin:editor' automatic-glob-alias no
        zstyle ':zephyr:plugin:editor' glob-alias no
        zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
        source <(COMPLETE=zsh jj)

        # Start tmux automatically
        export ZSH_TMUX_AUTOSTART=true

        # Reattach to existing session
        export ZSH_TMUX_AUTOCONNECT=true

        # Name session from current directory
        export ZSH_TMUX_AUTONAME_SESSION=true

        # Better TERM handling
        export ZSH_TMUX_FIXTERM=true

        export ZSH_TMUX_AUTOQUIT=false
      '';
      zshLate = lib.mkOrder 1000 ''
        _fix_cursor() { echo -ne '\e[2 q'; }
        precmd_functions+=(_fix_cursor)
        zle-line-init() { echo -ne '\e[2 q'; }
        zle -N zle-line-init
      '';
    in
      lib.mkMerge [zshEarly zshLate];

    antidote = {
      enable = true;
      plugins = [
        ''
          romkatv/zsh-defer
          mattmc3/zephyr path:plugins/editor
          mattmc3/zephyr path:plugins/utility
          mattmc3/zephyr path:plugins/directory
          mattmc3/zephyr path:plugins/zfunctions
          mattmc3/zephyr path:plugins/completion

          zsh-users/zsh-completions
          Aloxaf/fzf-tab
          getantidote/use-omz

          nix-community/nix-zsh-completions
          zsh-users/zsh-autosuggestions kind:defer
          zsh-users/zsh-history-substring-search kind:defer
          ohmyzsh/ohmyzsh path:plugins/tmux

          zdharma-continuum/fast-syntax-highlighting kind:defer
        ''
      ];
    };
  };
  imports = [
    ./prompt/starship.nix
  ];
}
