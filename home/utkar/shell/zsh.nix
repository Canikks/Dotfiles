{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = [
      "history"
      "completion"
    ];
    enableVteIntegration = true;
    history.size = 10000;
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "HIST_FIND_NO_DUPS"
      "HIST_IGNORE_SPACE"
    ];

    # Aliases
    shellAliases = {
      ls = "eza --color=always --icons=always";
      ll = "eza -l --color=always --icons=always";
      la = "eza -la --color=always --icons=always";
      gs = "git status -u";
      nix = "noglob nix";
      nom = "noglob nom";
    };

    # Plugins
    antidote.enable = true;
    antidote.plugins = [
      "olets/zsh-abbr kind:defer"
      "mattmc3/zephyr path:plugins/color"
      "mattmc3/zephyr path:plugins/editor"
      "mattmc3/zephyr path:plugins/utility"
      "mattmc3/zephyr path:plugins/history"
      "mattmc3/zephyr path:plugins/directory"
      "mattmc3/zephyr path:plugins/compstyle"
      "mattmc3/zephyr path:plugins/prompt"
      "mattmc3/zephyr path:plugins/directory"
      "zsh-users/zsh-autosuggestions"
      "mattmc3/zephyr path:plugins/zfunctions"
      "zdharma-continuum/fast-syntax-highlighting kind:defer"
      "mattmc3/zephyr path:plugins/completion"
      "zsh-users/zsh-history-substring-search"
    ];

    initContent = ''
      nix-your-shell zsh | source /dev/stdin
    '';
    prezto = {
      enable = true;
      editor = {
        dotExpansion = true;
      };
    };
  };
}
