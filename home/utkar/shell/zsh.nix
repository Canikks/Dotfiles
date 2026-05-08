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
      rg = "rg --hyperlink-format=kitty";
      gpra = "git pull --rebase --autostash";
      df = "duf";
      curl = "curlie";
      cp = "xcp";
      rm = "trash";
    };

    initContent = lib.mkOrder 500 ''
      # Fish-like speed optimizations ⚡
      zstyle ':zephyr:plugin:completion' 'use-cache' 'yes'
      zstyle ':zephyr:plugin:completion' 'use-xdg-basedirs' 'yes'
      zstyle ':zephyr:plugin:completion' 'compstyle' 'zephyr'
      ZSH_AUTOSUGGEST_USE_ASYNC=1
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

      # Completion Enhancements 🌈
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive completion
      zstyle ':completion:*' group-name              # Group completions
      zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f' # Cute descriptions

      alias -s {md,txt,json,yaml,toml,xml,conf,ini,log}=bat
      zstyle ':zephyr:plugin:editor' dot-expansion yes
      zstyle ':zephyr:plugin:editor' magic-enter yes
      zstyle ':zephyr:plugin:editor' automatic-glob-alias yes
      source <(COMPLETE=zsh jj)
    '';

    antidote = {
      enable = true;
      plugins = [
        ''
          romkatv/zsh-defer
          mattmc3/zephyr path:plugins/editor
          mattmc3/zephyr path:plugins/utility
          mattmc3/zephyr path:plugins/directory
          mattmc3/zephyr path:plugins/zfunctions

          # "mattmc3/zephyr path:plugins/compstyle"
          mattmc3/zephyr path:plugins/completion
          zsh-users/zsh-completions
          Aloxaf/fzf-tab

          QuarticCat/zsh-smartcache

          nix-community/nix-zsh-completions
          zsh-users/zsh-autosuggestions kind:defer
          zsh-users/zsh-history-substring-search kind:defer

          zdharma-continuum/fast-syntax-highlighting kind:defer
        ''
      ];
    };
  };
  imports = [
    ./prompt/starship.nix
  ];
}
