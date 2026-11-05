{
  pkgs,
  # inputs,
  ...
}: {
  programs.fish = {
    preferAbbrs = true;
    enable = true;
    shellAliases = {
      gs = "git status -u";
      gpra = "git pull --rebase --autostash";
      cat = "bat";
      diff = "batdiff";
      # rg = "rga --hyperlink-format=kitty";
      man = "batman";
      df = "duf";
      curl = "curlie";
      cp = "xcp";
      rm = "trash";
    };
    plugins = [
      {
        name = "fifc";
        src = pkgs.fishPlugins.fifc.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "fish-bd";
        src = pkgs.fishPlugins.fish-bd.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
    shellInit = ''
      set -g fish_greeting ""
    '';
    interactiveShellInit = ''
      set -g fish_color_autosuggestion brblack
      set -Ux fzfish_editor nvim
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
  imports = [
    ./prompt/starship.nix
  ];
}
