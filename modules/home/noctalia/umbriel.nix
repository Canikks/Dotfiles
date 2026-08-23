{pkgs, ...}: {
  programs.umbriel = {
    enable = true;
    settings = {
      include.file = [
        "noctalia.toml"
      ];
      general.autostart = ["noctalia"];
      layout.gap = 5;
      input.keyboard.layout = "us";
      appearance.blur = {
        enabled = true;
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
      };
    };
  };
}
