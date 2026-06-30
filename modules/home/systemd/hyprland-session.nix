{
  systemd.user.targets = {
    hyprland-session = {
      Unit = {
        Description = "Hyprland Session Target";
        Requires = "graphical-session.target";
        After = "graphical-session.target";
      };
    };
  };
}
