{
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntegration = true;
    extraPackages = with pkgs; [
      yaziPlugins.yatline
      yaziPlugins.yatline-githead
      yaziPlugins.full-border
      yaziPlugins.mount
      yaziPlugins.recycle-bin
      trash-cli
      yaziPlugins.sudo
      yaziPlugins.diff
    ];
    plugins = {
      yatline = pkgs.yaziPlugins.yatline;
      yatline-githead = pkgs.yaziPlugins.yatline-githead;
      full-border = pkgs.yaziPlugins.full-border;
      mount = pkgs.yaziPlugins.mount;
      recycle-bin = pkgs.yaziPlugins.recycle-bin;
      sudo = pkgs.yaziPlugins.sudo;
      diff = pkgs.yaziPlugins.diff;
    };
    initLua = ''
            require("yatline"):setup({
            	section_separator = { open = "", close = "" },
            	part_separator = { open = "", close = "" },
            	inverse_separator = { open = "", close = "" },
            	permissions_t_fg = "green",
            	permissions_r_fg = "yellow",
            	permissions_w_fg = "red",
            	permissions_x_fg = "cyan",
            	permissions_s_fg = "white",

            	tab_width = 20,
            	tab_use_inverse = false,

            	selected = { icon = "󰻭", fg = "yellow" },
            	copied = { icon = "", fg = "green" },
            	cut = { icon = "", fg = "red" },

            	total = { icon = "󰮍", fg = "yellow" },
            	succ = { icon = "", fg = "green" },
            	fail = { icon = "", fg = "red" },
            	found = { icon = "󰮕", fg = "blue" },
            	processed = { icon = "󰐍", fg = "green" },

            	show_background = true,

            	display_header_line = true,
            	display_status_line = true,

            	component_positions = { "header", "tab", "status" },

            	header_line = {
            		left = {
            			section_a = {
                    			{type = "line", custom = false, name = "tabs", params = {"left"}},
            			},
            			section_b = {
                          {type = "coloreds", custom = false, name = "githead"},
            			},
            			section_c = {
            			}
            		},
            		right = {
            			section_a = {
                    			{type = "string", custom = false, name = "date", params = {"%A, %d %B %Y"}},
            			},
            			section_b = {
                    			{type = "string", custom = false, name = "date", params = {"%X"}},
            			},
            			section_c = {
            			}
            		}
            	},

            	status_line = {
            		left = {
            			section_a = {
                    			{type = "string", custom = false, name = "tab_mode"},
            			},
            			section_b = {
                    			{type = "string", custom = false, name = "hovered_size"},
            			},
            			section_c = {
                    			{type = "string", custom = false, name = "hovered_path"},
                    			{type = "coloreds", custom = false, name = "count"},
            			}
            		},
            		right = {
            			section_a = {
                    			{type = "string", custom = false, name = "cursor_position"},
            			},
            			section_b = {
                    			{type = "string", custom = false, name = "cursor_percentage"},
            			},
            			section_c = {
                    			{type = "string", custom = false, name = "hovered_file_extension", params = {true}},
                    			{type = "coloreds", custom = false, name = "permissions"},
            			}
            		}
            	},
            })
      require("yatline-githead"):setup()
      require("full-border"):setup {
      	type = ui.Border.ROUNDED,
      }
      require("recycle-bin"):setup()
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
          on = ["D" "s"];
          run = "plugin diff";
          desc = "Diff the selected with the hovered file";
        }
      ];
    };
  };
}
