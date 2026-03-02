{...}: {
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
      tab_bar_style = "powerline";
      cursor_trail = 1;
      wayland_titlebar_color = "system";
      background_opacity = 0.7;
    };
  };
}
