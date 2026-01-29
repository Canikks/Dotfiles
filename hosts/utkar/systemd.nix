{pkgs, ...}: {
  systemd = {
    user.services.niri-flake-polkit.enable = false;
    user.targets = {
      mango-session.description = "MangoWC Session Target";
      mango-session.requires = ["graphical-session.target"];
      mango-session.after = ["graphical-session.target"];
    };
    # user.services.xwayland-satellite = {
    #   description = "Xwayland Satellite (rootless X11 for Wayland compositors)";
    #   documentation = ["man:xwayland-satellite(1)"];
    #   wantedBy = ["graphical-session.target"];
    #   partOf = ["graphical-session.target"];
    #   serviceConfig = {
    #     ExecStart = "/run/current-system/sw/bin/xwayland-satellite";
    #     Restart = "on-failure";
    #     RestartSec = 2;
    #     Type = "simple";
    #     Slice = "session.slice";
    #     ConditionEnvironment = "WAYLAND_DISPLAY";
    #   };
    # };
    user.tmpfiles.enable = true;
    tmpfiles.rules = [
      "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware}"
    ];
  };
}
