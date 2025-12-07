{
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntegration = true;
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
    };
    settings = {
      plugin = {
        prepand_previewers = [
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
        ];
      };
    };
    initLua = ''
      require("yatline"):setup({
      	show_background = true,

      	header_line = {
      		left = {
      			section_a = {
              			{type = "line", custom = false, name = "tabs", params = {"left"}},
      			},
      			section_b = {
      			},
      			section_c = {
              			{type = "coloreds", custom = false, name = "permissions"},
      			}
      		},
      		right = {
      			section_a = {
              			{type = "coloreds", custom = true, name = {{" 󰇥 ", "#3c3836"}}},
      			},
      			section_b = {
      			},
      			section_c = {
              			{type = "coloreds", custom = false, name = "count"},
      			}
      		}
      	},

      	status_line = {
      		left = {
      			section_a = {
      			},
      			section_b = {
      			},
      			section_c = {
      			}
      		},
      		right = {
      			section_a = {
      			},
      			section_b = {
      			},
      			section_c = {
      			}
      		}
      	},
      })
      require("full-border"):setup {
            	type = ui.Border.ROUNDED,
      }
      require("recycle-bin"):setup()
      require("no-status"):setup()
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
      ];
    };
  };
}
