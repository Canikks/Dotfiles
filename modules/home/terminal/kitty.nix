{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    shellIntegration.enableZshIntegration = true;
    enableGitIntegration = true;
    font.name = "Maple Mono NF SemiBold";
    shellIntegration.mode = "no-cursor";
    # extraConfig = ''
    #   include dank-tabs.conf
    #   include dank-theme.conf
    # '';
    extraConfig = ''
      include themes/noctalia.conf
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
      "f1" = "launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay moor --statusbar=bold --no-linenumbers";
      "f2" = "launch --stdin-source=@last_cmd_output --stdin-add-formatting --type=overlay moor --statusbar=bold --no-linenumbers";
    };
    settings = {
      scrollback_pager = "moor --statusbar=bold --no-linenumbers";
      auto_reload_config = "-1";
      allow_remote_control = "socket-only";
      # listen_on = "unix:/tmp/kitty";
      cursor_shape = "block";
      input_delay = 0;
      repaint_delay = 2;
      wayland_enable_ime = "no";
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      cursor_trail = 1;
      wayland_titlebar_color = "system";
      background_opacity = 0.5;
      pixel_scroll = "yes";
      momentum_scroll = 0.96;
      # scrollback_pager = "less -R --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
    };
  };
}
