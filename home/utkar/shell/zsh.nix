{config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = ["history" "completion" "match_prev_cmd"];
    enableVteIntegration = true;
    # enableGlobalCompInit = true;
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
      # nfu = "sudo nixos-rebuild switch --impure --flake /etc/nixos#utkar";
    };

    # Plugins
    antidote.enable = true;
    antidote.plugins = [
      "olets/zsh-abbr kind:defer"
      "belak/zsh-utils path:editor"
      "belak/zsh-utils path:utility"
      "belak/zsh-utils path:history"
      "zsh-users/zsh-autosuggestions"
      "mattmc3/zfunctions"
      "zdharma-continuum/fast-syntax-highlighting kind:defer"
      "zsh-users/zsh-completions kind:fpath path:src"
      "zsh-users/zsh-history-substring-search"
      "romkatv/powerlevel10k"
    ];

    initContent = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    prezto = {
      enable = true;
      color = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
        promptContext = true;
      };
    };
  };
}
