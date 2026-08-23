{pkgs, ...}: {
  programs.umbriel = {
    enable = true;
    settings = {
      general.autostart = ["noctalia"];
      layout.gap = 5;
      # input.keyboard.layout = "de";
      keybinds = {
        "Mod+Return" = "spawn:kitty";
        "Mod+Q" = "window-close";
        "Mod" = "spawn:noctalia msg panel-toggle launcher";
        "Mod+Tab" = "overview-toggle";
        "Mod+Bracketright" = "window-focus-next";
        "Mod+Bracketleft" = "window-focus-previous";
        "Mod+1" = "column-move-to-workspace:1";
        "Mod+2" = "column-move-to-workspace:1";
        "Mod+3" = "column-move-to-workspace:1";
      };
    };
  };
}
