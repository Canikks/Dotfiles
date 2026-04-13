{
  pkgs,
  inputs,
  ...
}: {
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      _7zz = pkgs._7zz-rar;
    };
    shellWrapperName = "y";
    theme = {
      flavor = {
        dark = "noctalia";
        light = "noctalia";
      };
    };
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
      jjui = pkgs.yaziPlugins.jjui;
    };
    settings = {
      opener = {
        extract = [
          {
            run = ''ouch d -y "$@"'';
            desc = "Extract here with ouch";
            for = "unix";
          }
        ];
      };
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
            run = "bat --color=always --style=plain --paging=never --wrap=never \"$1\"";
          }
          {
            name = "*.md";
            run = "bat --color=always --style=plain --paging=never \"$1\"";
          }
          {
            name = "*.nix";
            run = "bat --color=always --style=plain --paging=never \"$1\"";
          }
          {
            mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
            run = "ouch --show-file-icons";
          }
        ];
      };
    };
    initLua = ''
      require("yatline"):setup({
      	section_separator = { open = "", close = "" },
      	part_separator = { open = "", close = "" },
      	inverse_separator = { open = "", close = "" },

      	padding = { inner = 1, outer = 1 },

      	style_a = {
      		bg = "white",
      		fg = "black",
      		bg_mode = {
      			normal = "white",
      			select = "brightyellow",
      			un_set = "brightred",
      		},
      	},
      	style_b = { bg = "brightblack", fg = "brightwhite" },
      	style_c = { bg = "black", fg = "brightwhite" },

      	permissions_t_fg = "green",
      	permissions_r_fg = "yellow",
      	permissions_w_fg = "red",
      	permissions_x_fg = "cyan",
      	permissions_s_fg = "white",

      	tab_width = 20,

      	selected = { icon = "󰻭", fg = "yellow" },
      	copied = { icon = "", fg = "green" },
      	cut = { icon = "", fg = "red" },

      	files = { icon = "", fg = "blue" },
      	filtereds = { icon = "", fg = "magenta" },

      	total = { icon = "󰮍", fg = "yellow" },
      	success = { icon = "", fg = "green" },
      	failed = { icon = "", fg = "red" },

      	show_background = true,

      	display_header_line = true,
      	display_status_line = true,

      	component_positions = { "header", "tab", "status" },

      	header_line = {
      		left = {
      			section_a = {
      				{ type = "line", name = "tabs" },
      			},
      			section_b = {},
      			section_c = {},
      		},
      		right = {
      			section_a = {
      				{ type = "string", name = "date", params = { "%A, %d %B %Y" } },
      			},
      			section_b = {
      				{ type = "string", name = "date", params = { "%X" } },
      			},
      			section_c = {},
      		},
      	},

      	status_line = {
      		left = {
      			section_a = {
      				{ type = "string", name = "tab_mode" },
      			},
      			section_b = {
      				{ type = "string", name = "hovered_size" },
      			},
      			section_c = {
      				{ type = "string", name = "hovered_path" },
      				{ type = "coloreds", name = "count" },
      			},
      		},
      		right = {
      			section_a = {
      				{ type = "string", name = "cursor_position" },
      			},
      			section_b = {
      				{ type = "string", name = "cursor_percentage" },
      			},
      			section_c = {
      				{ type = "string", name = "hovered_file_extension", params = { true } },
      				{ type = "coloreds", name = "permissions" },
      			},
      		},
      	},
      })
      require("recycle-bin"):setup()
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
        {
          on = ["g" "j"];
          run = "plugin jjui";
          desc = "run jjui";
        }
        # {
        #   on = "p";
        #   run = "plugin ucp paste notify";
        #   desc = "Paste";
        # }
        # {
        #   on = "y";
        #   run = "plugin ucp copy notify";
        #   desc = "Copy";
        # }
      ];
    };
  };
}
