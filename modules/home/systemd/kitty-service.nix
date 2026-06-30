{pkgs, ...}: {
  systemd.user.services = {
    kitty-session = {
      Service.ExecStart = "${pkgs.kitty}/bin/kitty --start-as=hidden --single-instance";
      Unit = {
        Description = "Kitty Systemd Daemon";
        X-SwitchMethod = "restart";
      };
    };
  };
}
