{
  pkgs,
  lib,
  ...
}: {
  systemd.user.services.kitty-daemon = {
    Unit = {
      Description = "Kitty daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      # X-SwitchMethod = "restart";
    };

    Service = {
      ExecStart = ''
        ${pkgs.kitty}/bin/kitty \
          --start-as=hidden \
          --listen-on unix:%t/kitty.sock
      '';

      # Restart = "on-failure";
      # RestartSec = 6;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
