{...}: {
  services = {
    flatpak = {
      enable = true;
    };

    spice-vdagentd.enable = true;

    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [
        "intel"
        "modesetting"
      ];
    };
    resolved = {
      enable = true;
      dnsovertls = "true";
      domains = ["~."];
      fallbackDns = ["1.1.1.1#cloudflare-dns.com"];
      extraConfig = ''
        DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net
      '';
    };

    gvfs = {
      enable = true;
    };

    udisks2 = {
      enable = true;
    };

    dbus = {
      enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [
        "--autopilot"
      ];
    };

    psd = {
      enable = true;
    };

    geoclue2 = {
      enable = true;
    };

    upower = {
      enable = true;
    };

    thermald = {
      enable = true;
    };

    tlp = {
      enable = false;
    };

    power-profiles-daemon = {
      enable = true;
    };
  };
}
