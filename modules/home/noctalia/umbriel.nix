{
  pkgs,
  config,
  ...
}: {
  programs.umbriel = {
    enable = true;
    settings = {
      include = {
        files = [
          "${config.xdg.configHome}/umbriel/noctalia.toml"
        ];
      };
      # general.autostart = ["noctalia"];
      layout.gap = 5;
      input.keyboard.layout = "us";
      input.keyboard.options = "compose:ralt,ctrl:swapcaps";
      appearance = {
        prefer_no_csd = true;
        border_width = 2;
        corner_radius = 10;
      };
      appearance.blur = {
        enabled = true;
        passes = 3;
        radius = 3;
        noise = 0.02;
        brightness = 0.9;
        contrast = 0.9;
        saturation = 1.1;
      };
      events = {
        lid_close = "umbriel msg dpms-off";
        lid_open = "umbriel msg dpms-on";
      };
      layer_rule = [
        {
          match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
          blur = true;
          blur_ignore_alpha = 0.5;
          blur_popups = true;
          blur_optimized = false;
        }
      ];
      window_rule = [
        {
          match.app_id = "^(Alacritty|kitty|org\\.gnome\\.Nautilus)$";
          default_scrolling_extent = 0.33;
        }

        {
          match.app_id = "^(helium|chromium)$";
          default_scrolling_extent = 0.75;
        }

        {
          match.content_type = "game";
          vrr = "always";
        }

        {
          match.xdg_tag = "^proton-game$";
          default_fullscreen = true;
        }

        {
          match.app_id = "^steam_app_[0-9]+$";
          hdr = "fullscreen";
        }

        {
          match.app_id = "^(steam_app_[0-9]+|gamescope)$";
          tearing = true;
        }

        {
          match.app_id = "^(code|org\\.gnome\\.Nautilus)$";
          opacity = 0.97;
        }

        {
          match.app_id = "^(Emulator|zenity|xdg-desktop-portal|qalculate-gtk|org\\.pulseaudio\\.pavucontrol)$";
          default_floating = true;
        }

        {
          match.title = "^(Open File|Select|Choose a wallpaper|Open Folder|Save As|Library|Choose Where to Download|File Operation Progress|Rename|Copy Files|Move Files|Search Files)";
          default_floating = true;
        }

        {
          match.app_id = "^(steam.*|overwatch|overwatch\\.exe)$";
          default_workspace = 4;
        }

        {
          match.app_id = "^(steam_proton|steam_app.*|overwatch|overwatch\\.exe)$";
          default_fullscreen = true;
        }

        {
          match.title = "^notificationtoasts_.+_desktop";
          default_position = {
            x = 0;
            y = 0;
            anchor = "bottom_right";
          };
          default_focused = false;
          default_pinned = true;
        }

        {
          match.app_id = "^dev.noctalia.Noctalia$";
          default_floating = true;
          default_floating_size_px = {
            width = 1020;
            height = 900;
          };
          blur_popups = false;
        }

        {
          match.app_id = "^dev.noctalia.UmbrielSharePicker$";
          default_floating = true;
          default_floating_size_px = {
            width = 800;
            height = 600;
          };
          default_position = {
            x = 32;
            y = 32;
            anchor = "bottom_right";
          };
        }

        {
          match.app_id = "^dev.lemmy.swash$";
          default_floating = true;
          default_floating_size_px = {
            width = 1000;
            height = 900;
          };
        }

        {
          match.is_focused = false;
          opacity = 0.85;
        }

        {
          match.is_focused = true;
          opacity = 1.0;
        }

        {
          match.is_floating = true;
          match.is_scratchpad = false;
          blur = false;
        }

        {
          match.is_focused = false;
          match.is_floating = true;
          match.is_scratchpad = false;
          opacity = 0.4;
        }
        {
          opacity = 0.7;
          blur = true;
          blur_popups = true;
          blur_optimized = false;
        }
      ];
      keybinds = {
        "Mod+Return" = "spawn kitty";
        "Mod+Q" = "window-close";
        "Mod" = "spawn noctalia msg panel-toggle launcher";
        "Mod+V" = "spawn noctalia msg panel-toggle clipboard";
        "Mod+W" = "spawn noctalia msg panel-toggle wallpaper";
        "Mod+N" = "spawn noctalia msg panel-toggle noctalia/notes:panel";
        "Mod+P" = "spawn noctalia msg screenshot-region";
        "Mod+X" = "spawn noctalia msg panel-toggle session";
        "Alt+Tab" = "spawn noctalia msg window-switcher";
        "Mod+Shift+A" = "spawn noctalia msg screenshot-annotate";
        "Mod+Ctrl+A" = "spawn noctalia msg annotate";
        "Mod+Tab" = "overview-toggle";
        "Mod+F" = "window-toggle-maximize";
        "Mod+Shift+Space" = "window-move-to-scratchpad";
        "Mod+Space" = "scratchpad-toggle";
        "Mod+Ctrl+Space" = "window-restore-from-scratchpad";
        "Mod+Bracketright" = "window-focus-next";
        "Mod+Bracketleft" = "window-focus-previous";
        "Mod+Shift+Bracketleft" = "column-move-left";
        "Mod+Shift+Bracketright" = "column-move-right";
        "Mod+Shift+1" = "column-move-to-workspace 1";
        "Mod+Shift+2" = "column-move-to-workspace 2";
        "Mod+Shift+3" = "column-move-to-workspace 3";
        "Mod+1" = "workspace-switch 1";
        "Mod+2" = "workspace-switch 2";
        "Mod+3" = "workspace-switch 3";
        "XF86AudioRaiseVolume" = "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "Mod+XF86AudioMute" = "spawn wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioPlay" = "spawn playerctl play-pause";
        "XF86AudioNext" = "spawn playerctl next";
        "XF86AudioPrev" = "spawn playerctl previous";
        "XF86MonBrightnessUp" = "spawn brightnessctl set +5%";
        "XF86MonBrightnessDown" = "spawn brightnessctl set 5%-";
      };
    };
  };
}
