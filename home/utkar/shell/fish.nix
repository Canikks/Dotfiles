{...}: {
  programs.fish = {
    preferAbbrs = true;
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      gs = "git status -u";
      zel = "zellij";
      zserver = "zellij --layout=server";
      gpra = "git pull --rebase --autostash";
      cat = "bat";
      diff = "batdiff";
      rg = "batgrep";
      man = "batman";
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
      set -Ux fifc_editor hx
      set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
      set -gx MANROFFOPT "-c"
      set -gx FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
      set -g fish_cursor_default block
      set -g fish_cursor_insert block
      set -g fish_cursor_visual block
      set -g fish_cursor_replace_one block
      set -g fish_cursor_replace block
      # Enable terminal integration (VTE-like)
      set -g fish_term24bit 1
    '';
  };
}
