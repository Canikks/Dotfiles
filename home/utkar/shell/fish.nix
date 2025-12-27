{...}: {
  programs.fish = {
    preferAbbrs = true;
    enable = true;
    shellAliases = {
      ls = "eza --color=always --icons=always";
      ll = "eza -l --color=always --icons=always";
      la = "eza -la --color=always --icons=always";
      gs = "git status -u";
      zel = "zellij";
      zserver = "zellij --layout=server";
    };
    shellInit = ''
      set -g fish_greeting ""
    '';
    interactiveShellInit = ''

      # History substring search is default in fish:
      # ↑ / ↓ already work as expected

      # Better colors
      set -g fish_color_autosuggestion brblack
      set -g fish_color_command blue
      set -g fish_color_param cyan
      set -g fish_color_error red

      # Enable terminal integration (VTE-like)
      set -g fish_term24bit 1
    '';
  };
}
