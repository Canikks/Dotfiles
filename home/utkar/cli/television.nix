{...}: {
  programs.television = {
    enable = true;
    enableFishIntegration = true;
    channels = {
      nix = {
        metadata = {
          name = "nix";
          requirements = ["nix-search-tv"];
        };
        source = {
          command = "nix-search-tv print";
        };
        preview = {
          command = "nix-search-tv preview {}";
        };
      };
      fish-history = {
        metadata = {
          name = "fish-history";
          requirements = ["fish"];
        };
        source = {
          command = "fish -c 'history'";
          sort_results = false;
        };
      };
      procs = {
        metadata = {
          name = "procs";
          description = "A channel to find and manage running processes";
          requirements = [
            "ps"
            "awk"
          ];
        };

        source = {
          command = "ps -e -o pid=,ucomm= | awk '{print $1, $2}'";
          display = "{split: :1}";
          output = "{split: :0}";
        };

        preview = {
          command = "ps -p '{split: :0}' -o user,pid,ppid,state,%cpu,%mem,command | fold";
        };

        keybindings = {
          "ctrl-k" = "actions:kill";
        };

        actions = {
          kill = {
            description = "Kill the selected process (SIGKILL)";
            command = "kill -9 {split: :0}";
            mode = "execute";
          };
        };
      };
      man-pages = {
        metadata = {
          name = "man-pages";
          description = "Browse and preview system manual pages";
          requirements = [
            "apropos"
            "man"
            "col"
          ];
        };

        source = {
          command = "apropos .";
        };

        preview = {
          command = "man '{0}' | col -bx";
          env = {
            MANWIDTH = "80";
          };
        };

        keybindings = {
          enter = "actions:open";
        };

        actions = {
          open = {
            description = "Open the selected man page in the system pager";
            command = "man '{0}'";
            mode = "execute";
          };
        };

        ui = {
          preview_panel = {
            header = "{0}";
          };
        };
      };
      files = {
        metadata = {
          name = "files";
          description = "A channel to select files and directories";
          requirements = [
            "fd"
            "bat"
          ];
        };

        source = {
          command = [
            "fd -t f"
            "fd -t f -H"
          ];
        };

        preview = {
          command = "bat -n --color=always '{}'";
          env = {
            BAT_THEME = "ansi";
          };
        };

        keybindings = {
          shortcut = "f1";
          f12 = "actions:edit";
          "ctrl-up" = "actions:goto_parent_dir";
        };

        actions = {
          edit = {
            description = "Opens the selected entries with the default editor (falls back to hx)";
            command = "hx '{}'";
            mode = "execute";
          };

          goto_parent_dir = {
            description = "Re-opens tv in the parent directory";
            command = "tv files ..";
            mode = "execute";
          };
        };
      };
      text = {
        metadata = {
          name = "text";
          description = "A channel to find and select text from files";
        };

        requirements = [
          "rg"
          "bat"
        ];

        source = {
          command = ''
            rg . \
              --no-heading \
              --line-number \
              --colors 'match:fg:white' \
              --colors 'path:fg:blue' \
              --color=always
          '';
          ansi = true;

          output = "{strip_ansi|split:\\::..2}";
        };

        preview = {
          command = "bat -n --color=always '{strip_ansi|split:\\::0}'";

          offset = "{strip_ansi|split:\\::1}";
        };

        preview.env = {
          BAT_THEME = "ansi";
        };

        ui.preview_panel = {
          header = "{strip_ansi|split:\\::..2}";
        };

        actions = {
          edit = {
            description = "Open match in Helix";
            command = "hx '{strip_ansi|split:\\::0}:{strip_ansi|split:\\::1}'";
            mode = "execute";
          };
        };
      };
    };
  };
}
