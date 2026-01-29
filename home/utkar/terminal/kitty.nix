{...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    shellIntegration.enableFishIntegration = true;
    enableGitIntegration = true;
    font.name = "MesloLGS Nerd Font";
    shellIntegration.mode = "no-cursor";
    extraConfig = ''
      include dank-tabs.conf
      include dank-theme.conf
    '';
    settings = {
      tab_bar_style = "powerline";
      cursor_trail = 1;
      wayland_titlebar_color = "system";
      background_opacity = 0.7;
    };
  };
}
