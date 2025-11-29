{config, ...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    systemd.enable = true;
    settings = {
      font-family = "CankaydiaCove Nerd Font Propo";
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      background-opacity = 0.90;
      background-blur-radius = 32;
      custom-shader = [
        "/home/utkar/.config/ghostty/shaders/cursor_warp.glsl"
        "/home/utkar/.config/ghostty/shaders/ripple_rectangle_cursor.glsl"
      ];
      config-file = "/home/utkar/.config/ghostty/config-dankcolors";
      cursor-style = "block";
      unfocused-split-opacity = 0.7;
      unfocused-split-fill = "#44464f";
      gtk-titlebar = false;
      # gtk-toolbar-style = "flat";
      shell-integration = "detect";
      shell-integration-features = "sudo,title,no-cursor";
    };
  };
  xdg.configFile."ghostty/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}
