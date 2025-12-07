{config, ...}: {
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

    # aria2 = {
    #   enable = true;
    #   rpcSecretFile = "/home/utkar/Dotfiles/modules/secret-rpc.txt";
    #   openPorts = true;
    #   serviceUMask = "0002";
    #   downloadDirPermission = "0770";
    #   settings = {
    #     dir = "/home/utkar/Downloads";
    #     enable-rpc = true;
    #     max-connection-per-server = 16;
    #     split = 16;
    #     min-split-size = "4M";
    #     file-allocation = "falloc";
    #     console-log-level = "error";
    #     summary-interval = 0;
    #     show-console-readout = true;
    #     rpc-allow-origin-all = true;
    #   };
    # };

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
