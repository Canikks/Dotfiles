{
  lib,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = false;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = ["history" "completion"];
    zprof.enable = false;

    history.size = 10000;
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "SHARE_HISTORY"
      "EXTENDED_HISTORY"
      "HIST_VERIFY"
      "INC_APPEND_HISTORY"
      "HIST_EXPIRE_DUPS_FIRST"
      "HIST_FIND_NO_DUPS"
      "HIST_IGNORE_SPACE"
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
      nix = "noglob nix";
      gpra = "git pull --rebase --autostash";
      df = "duf";
      curl = "curlie";
      cp = "xcp";
      rm = "trash";
      pass-push = "git -C ~/.local/share/gopass/stores/root push";
      pass-pull = "git -C ~/.local/share/gopass/stores/root pull --rebase";
    };

    initContent = let
      zshEarly = lib.mkOrder 500 ''
        # Fish-like speed optimizations ⚡
        zstyle ':zephyr:plugin:completion' 'use-cache' 'yes'
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh"
        zstyle ':completion:*' rehash true
        zstyle ':completion:*' use-cache true
        zstyle ':completion:*' use-xdg-basedirs true
        zstyle ':plugin:ez-compinit' use-cache yes
        zstyle ':plugin:ez-compinit' use-xdg-basedirs yes
        zstyle ':zephyr:plugin:completion' 'use-xdg-basedirs' 'yes'
        zstyle ':zephyr:plugin:completion' 'compstyle' 'zephyr'
        ZSH_AUTOSUGGEST_USE_ASYNC=1
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=100

        # Completion Enhancements 🌈
        zstyle ':completion:*' matcher-list \
            'm:{a-z}={A-Z}' \
            'r:|=*' \
            'l:|=* r:|=*'
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':completion:*' group-name              # Group completions
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
        zstyle ':fzf-tab:*' switch-group '<' '>'
        zstyle ':fzf-tab:*' show-group quiet
        zstyle ':fzf-tab:*' fzf-pad 4
        zstyle ':fzf-tab:*' query-string input
        zstyle ':fzf-tab:*' accept-line enter

        alias -s {md,txt,json,yaml,toml,xml,conf,ini,log}=bat
        zstyle ':zephyr:plugin:editor' dot-expansion yes
        zstyle ':zephyr:plugin:editor' magic-enter yes
        zstyle ':zephyr:plugin:editor' automatic-glob-alias no
        zstyle ':zephyr:plugin:editor' glob-alias no
        # zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
        # zstyle ':fzf-tab:*' use-fzf-default-opts no
        zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept --popup
        source <(COMPLETE=zsh jj)
        export MOOR='--statusbar=bold --no-linenumbers'
        # export FZF_DEFAULT_OPTS='--popup'

        # Start tmux automatically
        export ZSH_TMUX_AUTOSTART=false

        # Reattach to existing session
        export ZSH_TMUX_AUTOCONNECT=true

        # Name session from current directory
        export ZSH_TMUX_AUTONAME_SESSION=true

        # Better TERM handling
        export ZSH_TMUX_FIXTERM=true

        export ZSH_TMUX_AUTOQUIT=false
        export PAGER=moor

        ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK      
        ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
        ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLOCK
        ZVM_INIT_MODE=sourcing
      '';
      zshLate = lib.mkOrder 1500 ''
        _fix_cursor() { echo -ne '\e[2 q'; }
        precmd_functions+=(_fix_cursor)
        zle-line-init() { echo -ne '\e[2 q'; }
        zle -N zle-line-init
      '';
    in
      lib.mkMerge [zshEarly];

    antidote = {
      enable = true;
      plugins = [
        ''
          mattmc3/zephyr path:plugins/editor
          mattmc3/zephyr path:plugins/utility
          mattmc3/zephyr path:plugins/directory
          mattmc3/zephyr path:plugins/zfunctions
          zsh-users/zsh-completions kind:fpath path:src
          mattmc3/ez-compinit

          jeffreytse/zsh-vi-mode

          zsh-users/zsh-history-substring-search

          hlissner/zsh-autopair

          Aloxaf/fzf-tab
        ''
      ];
    };
  };
  imports = [
    ./prompt/starship.nix
  ];
}
