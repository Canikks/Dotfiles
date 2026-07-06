{
  systemd.user.targets = {
    hyprland-session = {
      Unit = {
        Description = "Hyprland Session Target";
        BindsTo = "graphical-session.target";
        Wants = ["graphical-session-pre.target" "xdg-desktop-autostart.target"];
        After = "graphical-session-pre.target";
        PropagatesStopTo = "graphical-session.target";
      };
    };
  };
}
