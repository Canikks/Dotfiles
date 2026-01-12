{...}: {
  programs.zsh = {
    enable = true;

    # 1. Keep this true to ensure Nix adds installed packages to $fpath
    # However, we rely on Zephyr (in antidote) to handle the actual `compinit` lazy loading.
    enableCompletion = true;

    # 2. DISABLE Home Manager's internal handling of these.
    # We will load faster versions via Antidote below.
    syntaxHighlighting.enable = false;
    autosuggestion.enable = false;
    enableVteIntegration = true;

    history.size = 10000;
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "HIST_FIND_NO_DUPS"
      "HIST_IGNORE_SPACE"
    ];

    sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      FZF_DEFAULT_OPTS = "--preview 'bat --style=numbers --color=always --line-range :500 {}'";
    };

    shellAliases = {
      ls = "eza --color=always --icons=always";
      ll = "eza -l --color=always --icons=always";
      la = "eza -la --color=always --icons=always";
      gs = "git status -u";
      nix = "noglob nix";
      cat = "bat";
      man = "batman";
      bg = "batgrep";
      diff = "batdiff";
    };

    initContent = ''
      alias -s {md,txt,json,yaml,toml,xml,conf,ini,log}=bat
      abbr b=bat
    '';

    antidote = {
      enable = true;
      plugins = [
        # --- Core Framework (Zephyr) ---
        "mattmc3/zephyr path:plugins/color"
        "mattmc3/zephyr path:plugins/editor"
        "mattmc3/zephyr path:plugins/utility"
        "mattmc3/zephyr path:plugins/history"
        "mattmc3/zephyr path:plugins/directory"
        "mattmc3/zephyr path:plugins/prompt"
        "mattmc3/zephyr path:plugins/zfunctions"

        # --- Completion ---
        # Load compstyle before completion
        "mattmc3/zephyr path:plugins/compstyle"
        "mattmc3/zephyr path:plugins/completion"

        # --- Deferred / Heavy Plugins ---
        # kind:defer delays loading until the prompt is ready
        "olets/zsh-abbr kind:defer"
        "zsh-users/zsh-autosuggestions kind:defer"
        "zsh-users/zsh-history-substring-search kind:defer"

        # --- Syntax Highlighting ---
        # MUST be last. deferred for speed.
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
      ];
    };

    # 3. REMOVED PREZTO
    # Prezto is monolithic and conflicts with Zephyr.
    # Removing this will likely shave 1-2 seconds off startup.
    # prezto = { ... };
  };
}
