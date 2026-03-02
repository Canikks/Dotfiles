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
      rg = "rga --hyperlink-format=kitty";
      df = "duf";
      curl = "curlie";
      cp = "xcp";
      rm = "trash";
    };

    initContent = lib.mkOrder 500 ''
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

        # --- Deferred / Heavy Plugins ---
        # kind:defer delays loading until the prompt is ready
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-history-substring-search"

        # --- Syntax Highlighting ---
        # MUST be last. deferred for speed.
        "zdharma-continuum/fast-syntax-highlighting"
      ];
    };
  };
  imports = [
    ./prompt/starship.nix
  ];
}
