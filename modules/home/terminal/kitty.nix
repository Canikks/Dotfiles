{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    shellIntegration.enableZshIntegration = true;
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
    };
    keybindings = {
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "f1" = "launch --stdin-source=@screen_scrollback --stdin-add-formatting less +G -R";
    };
    settings = {
      auto_reload_config = "-1";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      cursor_shape = "block";
      input_delay = 0;
      repaint_delay = 2;
      wayland_enable_ime = "no";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      cursor_trail = 1;
      wayland_titlebar_color = "system";
      background_opacity = 0.7;
      pixel_scroll = "yes";
    };
  };
}
