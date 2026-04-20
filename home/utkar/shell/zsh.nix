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
      nix = "noglob nix";
      cat = "bat";
      man = "batman";
      bg = "batgrep";
      diff = "batdiff";
      rg = "rg --hyperlink-format=kitty";
      df = "duf";
      curl = "curlie";
      cp = "xcp";
      rm = "trash";
    };

    initContent = lib.mkOrder 500 ''
      # Fish-like speed optimizations ⚡
      ZSH_AUTOSUGGEST_USE_ASYNC=1
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

      # Completion Enhancements 🌈
      # Cursor Shape: Block 📦
      echo -ne '\e[1 q'
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive completion
      zstyle ':completion:*' group-name              # Group completions
      zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f' # Cute descriptions

      alias -s {md,txt,json,yaml,toml,xml,conf,ini,log}=bat
      zstyle ':zephyr:plugin:editor' dot-expansion yes
      zstyle ':zephyr:plugin:editor' magic-enter yes
      zstyle ':zephyr:plugin:editor' automatic-glob-alias yes
    '';

    antidote = {
      enable = true;
      plugins = [
        # --- Core Framework (Zephyr) ---
        "mattmc3/zephyr path:plugins/color"
        "mattmc3/zephyr path:plugins/editor"
        "mattmc3/zephyr path:plugins/utility"
        # "mattmc3/zephyr path:plugins/history"
        "mattmc3/zephyr path:plugins/directory"
        "mattmc3/zephyr path:plugins/zfunctions"

        # --- Completion ---
        # Load compstyle before completion
        "mattmc3/zephyr path:plugins/compstyle"
        "mattmc3/zephyr path:plugins/completion"
        "zsh-users/zsh-completions"
        "Aloxaf/fzf-tab"

        # --- Deferred / Heavy Plugins ---
        # kind:defer delays loading until the prompt is ready
        "zsh-users/zsh-autosuggestions kind:defer"
        "zsh-users/zsh-history-substring-search kind:defer"

        # --- Syntax Highlighting ---
        # MUST be last. deferred for speed.
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
      ];
    };
  };
  imports = [
    ./prompt/starship.nix
  ];
}
