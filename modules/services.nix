{pkgs, ...}: {
  services = {
    flatpak = {
      enable = true;
    };

    aria2 = {
      enable = true;
      rpcSecretFile = "/home/utkar/dotfiles/modules/secret-rpc.txt";
      settings = {
        enable-rpc = true;
        dir = "/home/utkar/Downloads";
        openPorts = true;
      };
    };

    avahi = {
      enable = true;
      reflector = true;
      publish = {
        enable = true;
      };
    };

    spice-vdagentd.enable = true;

    clamav = {
      scanner = {
        enable = true;
        scanDirectories = [
          "/home/utkar/Downloads"
          "/tmp"
          "/var/lib"
          "/var/tmp"
        ];
      };
      daemon = {
        enable = true;
      };
      fangfrisch = {
        enable = true;
      };
      updater = {
        enable = true;
      };
    };

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
      implementation = "broker";
    };

    pipewire = {
      enable = true;
      wireplumber = {
        enable = true;
        extraLv2Packages = with pkgs; [
          lsp-plugins
          zam-plugins
          calf
          mda_lv2
        ];
      };
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

    fwupd = {
      enable = true;
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
