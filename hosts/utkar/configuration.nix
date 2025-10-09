# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ../../modules/common.nix
    # ../../packages.nix
    ../../hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  networking.hostName = "utkar"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Set the default locale to English (India) with UTF-8 encoding
  i18n.defaultLocale = "en_GB.UTF-8";

  # Ensure en_IN.UTF-8 locale is supported by glibc

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  xdg.autostart = {
    enable = true;
  };

  services = {
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
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersaver";
          turbo = "never";
        };
        charger = {
          governer = "performance";
          turbo = "auto";
        };
      };
    };
  };

  programs.xwayland = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  # this is where services should be set.
  services = {
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
    aria2 = {
      enable = true;
      rpcSecretFile = "/home/utkar/secret-rpc.txt";
      openPorts = true;
      settings = {
        enable-rpc = true;
        max-connection-per-server = 16;
        split = 16;
        rpc-allow-origin-all = true;
      };
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
  };

  security = {
    polkit = {
      enable = true;
    };
    rtkit = {
      enable = true;
    };
    sudo-rs = {
      enable = true;
    };
  };

  # This is where environment stuff should be done.
  # This is a temperary config as I will be trying to make this a module.
  environment = {
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      NIXOS_OZONE_WL = "1";
      OZONE_PLATFORM = "wayland";
      STEAM_USE_NATIVE_LIBRARIES = "1";
      STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
      # DMS_RUN_GREETER = "1 qs -p ${pkgs.dms}/bin/dms";
    };
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      TERMINAL = "ghostty";
    };
    etc = {
      "polkit-1/rules.d/10-udisks2.rules" = {
        text = ''
          polkit.addRule(function(action, subject) {
            if ((action.id.indexOf("org.freedesktop.udisks2.") == 0) &&
                subject.isInGroup("wheel")) {
              return polkit.Result.YES;
            }
          });
        '';
      };
      "xdg/wayland-sessions/niri.desktop" = {
        text = ''
          [Desktop Entry]
          Name=Niri
          Comment=Niri Wayland Compositor
          Exec=${pkgs.dbus}/bin/dbus-run-session ${pkgs.niri}/bin/niri-session
          Type=Application
          DesktopNames=niri
        '';
      };
    };
  };

  # virtualisation.containers.enable = true;
  virtualisation = {
    containers = {
      enable = true;
    };
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.utkar = {
    isNormalUser = true;
    description = "utkar";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
    ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      sddm-astronaut
    ];
    theme = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  hardware.graphics.extraPackages = with pkgs; [
    mesa
    vaapi-intel-hybrid
    vaapiIntel
    vaapiVdpau
    vpl-gpu-rt
    intel-media-driver
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # programs = {
  #   bat = {
  #     enable = true;
  #   };
  #   zoxide = {
  #     enable = true;
  #     enableZshIntegration = true;
  #   };
  #   neovim = {
  #     enable = true;
  #   };

  #   git = {
  #     enable = true;
  #     lfs = {
  #       enable = true;
  #     };
  #   };

  #   niri = {
  #     enable = true;
  #   };
  #   television = {
  #     enable = true;
  #     enableZshIntegration = true;
  #   };
  #   zsh = {
  #     enable = true;
  #     enableCompletion = true;
  #     enableBashCompletion = true;
  #     syntaxHighlighting.enable = true;
  #     autosuggestions.enable = true;
  #     zsh-autoenv.enable = true;
  #     # Zsh options
  #     histSize = 10000;
  #     setOptions = [
  #       "HIST_IGNORE_ALL_DUPS"
  #       "HIST_FIND_NO_DUPS"
  #       "HIST_IGNORE_SPACE"
  #     ];

  #     # Aliases
  #     shellAliases = {
  #       ll = "ls -l";
  #       la = "ls -la";
  #       gs = "git status";
  #       nfu = "sudo nixos-rebuild switch --impure --flake /etc/nixos#utkar";
  #     };

  #     # Plugins
  #     ohMyZsh.plugins = [
  #       { name = "zsh-users/zsh-autosuggestions"; }
  #       { name = "zsh-users/zsh-syntax-highlighting"; }
  #       { name = "zsh-users/zsh-completions"; }
  #       { name = "zsh-users/zsh-history-substring-search"; }
  #       { name = "junegunn/fzf"; }
  #       { name = "romkatv/powerlevel10k"; }
  #     ];

  #     # Prompt
  #     promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #   };
  #   uwsm = {
  #     enable = true;
  #     waylandCompositors = {
  #       niri = {
  #         prettyName = "Niri";
  #         comment = "Niri compositor managed by UWSM";
  #         binPath = "/run/current-system/sw/bin/niri-session";
  #       };
  #     };
  #   };
  #   steam = {
  #     enable = true;
  #     extest.enable = true;
  #   };
  #   gamescope = {
  #     enable = true;
  #   };
  #   gamemode = {
  #     enable = true;
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
