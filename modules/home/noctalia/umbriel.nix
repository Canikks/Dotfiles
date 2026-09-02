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
      appearance.blur = {
        enabled = true;
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
          opacity = 0.7;
          blur = true;
          blur_popups = true;
          blur_optimized = false;
        }
      ];
      keybinds = {
        "Mod+Return" = "spawn:kitty @ launch --type=os-window";
        "Mod+Q" = "window-close";
        "Mod" = "spawn:noctalia msg panel-toggle launcher";
        "Mod+V" = "spawn:noctalia msg panel-toggle clipboard";
        "Mod+W" = "spawn:noctalia msg panel-toggle wallpaper";
        "Mod+N" = "spawn:noctalia msg panel-toggle noctalia/notes:panel";
        "Mod+P" = "spawn:noctalia msg screenshot-region";
        "Mod+X" = "spawn:noctalia msg panel-toggle session";
        "Mod+Shift+A" = "spawn:noctalia msg screenshot-annotate";
        "Mod+Ctrl+A" = "spawn:noctalia msg annotate";
        "Mod+Tab" = "overview-toggle";
        "Mod+F" = "window-toggle-maximize";
        "Mod+Shift+Space" = "window-move-to-scratchpad";
        "Mod+Space" = "scratchpad-toggle";
        "Mod+Ctrl+Space" = "window-restore-from-scratchpad";
        "Mod+Bracketright" = "window-focus-next";
        "Mod+Bracketleft" = "window-focus-previous";
        "Mod+Shift+Bracketleft" = "column-move-left";
        "Mod+Shift+Bracketright" = "column-move-right";
        "Mod+Shift+1" = "column-move-to-workspace:1";
        "Mod+Shift+2" = "column-move-to-workspace:2";
        "Mod+Shift+3" = "column-move-to-workspace:3";
        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "XF86AudioRaiseVolume" = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "Mod+XF86AudioMute" = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioPlay" = "spawn:playerctl play-pause";
        "XF86AudioNext" = "spawn:playerctl next";
        "XF86AudioPrev" = "spawn:playerctl previous";
        "XF86MonBrightnessUp" = "spawn:brightnessctl set +5%";
        "XF86MonBrightnessDown" = "spawn:brightnessctl set 5%-";
      };
    };
  };
}
