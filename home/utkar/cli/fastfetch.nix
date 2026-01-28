{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
        padding = {
          right = 2;
        };
      };

      display = {
        color = "blue";
        separator = "  ";
        size = {
          binaryPrefix = "si";
        };

        bar = {
          border = {
            left = "";
            right = "";
          };
          char = {
            elapsed = "█";
            total = "░";
          };
        };
      };

      modules = [
        {
          type = "title";
          format = "{1} @ {2}";
        }

        {
          type = "datetime";
          key = "󰥔 Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "󱑍 Time";
          format = "{14}:{17}:{20}";
        }

        "break"

        {
          type = "os";
          key = "󱄅 OS";
        }
        {
          type = "kernel";
          key = "󰌢 Kernel";
        }
        {
          type = "uptime";
          key = "󱫐 Uptime";
        }
        {
          type = "packages";
          key = "󰏖 Packages";
        }

        "break"

        {
          type = "cpu";
          key = "󰍛 CPU";
        }
        {
          type = "gpu";
          key = "󰢮 GPU";
        }
        {
          type = "memory";
          key = "󰘚 Memory";
        }
        {
          type = "disk";
          key = "󰋊 Disk";
        }
        {
          type = "battery";
          key = "󰁹 Battery";
        }

        "break"

        {
          type = "de";
          key = "󰧨 DE";
        }
        {
          type = "wm";
          key = "󱂬 WM";
        }
        {
          type = "terminal";
          key = " Terminal";
        }
        {
          type = "shell";
          key = "󰆍 Shell";
        }
        {
          type = "editor";
          key = "󰏫 Editor";
        }
        {
          type = "resolution";
          key = "󰍹 Resolution";
        }

        "break"

        {
          type = "hostname";
          key = "󰒋 Host";
        }
        {
          type = "localIp";
          key = "󰩠 Local IP";
        }
        {
          type = "publicIp";
          key = "󰩟 Public IP";
        }

        "break"

        {
          type = "player";
          key = "󰎆 Player";
        }
        {
          type = "media";
          key = "󰝚 Media";
        }

        "break"

        {
          type = "emoji";
          key = "󰞅 Mood";
        }
      ];
    };
  };
}
