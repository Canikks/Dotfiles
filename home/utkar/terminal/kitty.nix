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
    quickAccessTerminalConfig = {
      lines = 35;
      edge = "center-sized";
      columns = 160;
      start_as_hidden = false;
      hide_on_focus_loss = false;
      background_opacity = 0.7;
    }
    ;
    settings = {
      tab_bar_style = "powerline";
      cursor_trail = 1;
      wayland_titlebar_color = "system";
      background_opacity = 0.7;
    };
  };
}
