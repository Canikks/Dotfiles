{pkgs, ...}: {
  systemd = {
    tpm2.enable = true;
    additionalUpstreamSystemUnits = [
      "soft-reboot.target"
      "systemd-soft-reboot.service"
    ];
    user.services.niri-flake-polkit.enable = false;
    user.targets = {
      mango-session.description = "MangoWC Session Target";
      mango-session.requires = ["graphical-session.target"];
      mango-session.after = ["graphical-session.target"];
    };
    user.tmpfiles.enable = true;
    tmpfiles.rules = [
      "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware}"
    ];
  };
}
