{pkgs, ...}: {
  systemd = {
    # --- Hardware & TPM ---
    tpm2.enable = true;

    # --- System Units ---
    additionalUpstreamSystemUnits = [
      "soft-reboot.target"
      "systemd-soft-reboot.service"
    ];

    # --- User Services & Targets ---
    user.services.niri-flake-polkit.enable = false;
    user.targets = {
      mango-session.description = "MangoWC Session Target";
      mango-session.requires = ["graphical-session.target"];
      mango-session.after = ["graphical-session.target"];
    };
    user.tmpfiles.enable = true;

    # --- Tmpfiles ---
    tmpfiles.rules = [
      "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
    ];
  };
}
