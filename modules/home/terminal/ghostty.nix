{
  pkgs,
  inputs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.ghostty-releasefast;
    enableFishIntegration = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    systemd.enable = true;
    settings = {
      # font-family = "MesloLGS Nerd Font";
      # font-size = 11;
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      background-opacity = 0.85;
      keybind = [
        "alt+left=unbind"
        "alt+right=unbind"
        "alt+up=unbind"
        "alt+down=unbind"
      ];
      config-file = ["/home/utkar/.config/dms-theme-sync/ghostty.conf"];
      custom-shader = [
        "/home/utkar/.config/ghostty/shaders/cursor_warp.glsl"
        "/home/utkar/.config/ghostty/shaders/ripple_rectangle_cursor.glsl"
      ];
      theme = "dankcolors";
      cursor-style = "block";
      unfocused-split-opacity = 0.7;
      unfocused-split-fill = "#44464f";
      gtk-titlebar = false;
      gtk-toolbar-style = "flat";
      gtk-tabs-location = "hidden";
      gtk-single-instance = true;
      linux-cgroup = "single-instance";
      shell-integration = "detect";
      shell-integration-features = "no-cursor";
    };
  };
  xdg.configFile."ghostty/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}
