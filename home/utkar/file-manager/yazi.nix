{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntegration = true;
    enableFishIntegration = true;
    extraPackages = with pkgs; [
      rich-cli
      yaziPlugins.ouch
      yaziPlugins.vcs-files
      yaziPlugins.no-status
      yaziPlugins.rich-preview
      yaziPlugins.lazygit
      yaziPlugins.yatline
      yaziPlugins.yatline-githead
      yaziPlugins.full-border
      yaziPlugins.mount
      yaziPlugins.recycle-bin
      trash-cli
      yaziPlugins.sudo
      yaziPlugins.diff
      yaziPlugins.rsync
      yaziPlugins.starship
      yaziPlugins.git
    ];
    plugins = {
      yatline = pkgs.yaziPlugins.yatline;
      yatline-githead = pkgs.yaziPlugins.yatline-githead;
      full-border = pkgs.yaziPlugins.full-border;
      mount = pkgs.yaziPlugins.mount;
      recycle-bin = pkgs.yaziPlugins.recycle-bin;
      sudo = pkgs.yaziPlugins.sudo;
      diff = pkgs.yaziPlugins.diff;
      rsync = pkgs.yaziPlugins.rsync;
      lazygit = pkgs.yaziPlugins.lazygit;
      rich-preview = pkgs.yaziPlugins.rich-preview;
      no-status = pkgs.yaziPlugins.no-status;
      vcs-files = pkgs.yaziPlugins.vcs-files;
      ouch = pkgs.yaziPlugins.ouch;
      starship = pkgs.yaziPlugins.starship;
      git = pkgs.yaziPlugins.git;
    };
    settings = {
      mgr = {
        linemode = "permissions";
        sort_by = "alphabetical";
      };
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            url = "*";
            run = "git";
          }
          {
            id = "git";
            url = "*/";
            run = "git";
          }
        ];
        prepend_previewers = [
          {
            name = "*.csv";
            run = "rich-preview";
          }
          {
            name = "*.md";
            run = "rich-preview";
          }
          {
            name = "*.nix";
            run = "rich-preview";
          }
          {
            mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
            run = "ouch";
          }
        ];
      };
    };
    initLua = ''
      require("starship"):setup({
          -- Hide flags (such as filter, find and search). This can be beneficial for starship themes
          -- which are intended to go across the entire width of the terminal.
          hide_flags = false,
          -- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
          flags_after_prompt = true,
          -- Custom starship configuration file to use
          -- config_file = "~/.config/starship_full.toml", -- Default: nil
          -- Whether to enable support for starship's right prompt (i.e. `starship prompt --right`).
          show_right_prompt = true,
          -- Whether to hide the count widget, in case you want only your right prompt to show up. Only has
          -- an effect when `show_right_prompt = true`
          hide_count = false,
          -- Separator to place between the right prompt and the count widget. Use `count_separator = ""`
          -- to have no space between the widgets.
          count_separator = " ",
        })
      require("recycle-bin"):setup()
      require("no-status"):setup()
      require("git"):setup()
    '';
    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["c" "m"];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = ["M"];
          run = "plugin mount";
          desc = "Open mount menu";
        }
        {
          on = ["R" "b"];
          run = "plugin recycle-bin";
          desc = "Open Recycle Bin menu";
        }
        {
          on = ["R" "p" "p"];
          run = "plugin sudo -- paste";
          desc = "sudo paste";
        }
        {
          on = ["R" "P"];
          run = "plugin sudo -- paste --force";
          desc = "sudo paste force";
        }
        {
          on = ["R" "r"];
          run = "plugin sudo -- rename";
          desc = "sudo rename";
        }
        {
          on = ["R" "p" "l"];
          run = "plugin sudo -- link";
          desc = "sudo link absolute";
        }
        {
          on = ["R" "p" "r"];
          run = "plugin sudo -- link --relative";
          desc = "sudo link relative";
        }
        {
          on = ["R" "p" "L"];
          run = "plugin sudo -- hardlink";
          desc = "sudo hardlink";
        }
        {
          on = ["R" "a"];
          run = "plugin sudo -- create";
          desc = "sudo create";
        }
        {
          on = ["R" "d"];
          run = "plugin sudo -- remove";
          desc = "sudo trash";
        }
        {
          on = ["R" "D"];
          run = "plugin sudo -- remove --permanently";
          desc = "sudo delete";
        }
        {
          on = "!";
          for = "unix";
          run = ''shell "$SHELL" --block'';
          desc = "Open $SHELL here";
        }
        {
          on = "<C-d>";
          run = "plugin diff";
          desc = "Diff the selected with the hovered file";
        }
        {
          on = ["R" "s"];
          run = "plugin rsync";
          desc = "Copy files using rsync";
        }
        {
          on = ["g" "i"];
          run = "plugin lazygit";
          desc = "run lazygit";
        }
        {
          on = ["g" "s"];
          run = "plugin vcs-files";
          desc = "Show Git file changes";
        }
        {
          on = ["C" "f"];
          run = "plugin ouch tar.xz";
          desc = "Compress with ouch";
        }
      ];
    };
  };
}
