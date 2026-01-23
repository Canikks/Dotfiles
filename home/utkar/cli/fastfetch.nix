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
        # ───── Header ─────
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

        # ───── System ─────
        {
          type = "os";
          key = "󱄅 OS"; # nf-linux-nixos
        }
        {
          type = "kernel";
          key = "󰌢 Kernel"; # nf-md-chip
        }
        {
          type = "uptime";
          key = "󱫐 Uptime"; # nf-md-timer
        }
        {
          type = "packages";
          key = "󰏖 Packages"; # nf-md-package-variant
        }

        "break"

        # ───── Hardware ─────
        {
          type = "cpu";
          key = "󰍛 CPU"; # nf-md-cpu-64-bit
        }
        {
          type = "gpu";
          key = "󰢮 GPU"; # nf-md-graphics
        }
        {
          type = "memory";
          key = "󰘚 Memory"; # nf-md-memory
        }
        {
          type = "disk";
          key = "󰋊 Disk"; # nf-md-harddisk
        }
        {
          type = "battery";
          key = "󰁹 Battery"; # nf-md-battery
        }

        "break"

        # ───── Desktop ─────
        {
          type = "de";
          key = "󰧨 DE"; # nf-md-desktop-classic
        }
        {
          type = "wm";
          key = "󱂬 WM"; # nf-md-view-dashboard
        }
        {
          type = "terminal";
          key = " Terminal"; # nf-dev-terminal
        }
        {
          type = "shell";
          key = "󰆍 Shell"; # nf-md-console
        }
        {
          type = "editor";
          key = "󰏫 Editor"; # nf-md-pencil
        }
        {
          type = "resolution";
          key = "󰍹 Resolution"; # nf-md-monitor
        }

        "break"

        # ───── Network ─────
        {
          type = "hostname";
          key = "󰒋 Host"; # nf-md-server
        }
        {
          type = "localIp";
          key = "󰩠 Local IP"; # nf-md-lan
        }
        {
          type = "publicIp";
          key = "󰩟 Public IP"; # nf-md-earth
        }

        "break"

        # ───── Media ─────
        {
          type = "player";
          key = "󰎆 Player"; # nf-md-music
        }
        {
          type = "media";
          key = "󰝚 Media"; # nf-md-play-circle
        }

        "break"

        # ───── Fun ─────
        {
          type = "emoji";
          key = "󰞅 Mood"; # nf-md-emoticon
        }
      ];
    };
  };
}
