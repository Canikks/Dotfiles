{...}: {
  programs.fish = {
    preferAbbrs = true;
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      gs = "git status -u";
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
      set -g fish_color_autosuggestion brblack
      set -g fish_color_command blue
      set -g fish_color_param cyan
      set -g fish_color_error red
      set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
      set -gx MANROFFOPT "-c"
      set -gx FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
      set -g fish_cursor_default block
      set -g fish_cursor_insert block
      set -g fish_cursor_visual block
      set -g fish_cursor_replace_one block
      set -g fish_cursor_replace block
      set -g fish_term24bit 1
    '';
  };
}
