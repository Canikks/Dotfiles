# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ../../packages.nix
    ../../modules/programs.nix
    ../../modules/services.nix
    ../../modules/environment.nix
    ../../hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        style = {
          wallpapers = [../../Pictures/maxresdefault.jpg];
        };
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = {
      bcachefs = true;
    };
    initrd.systemd.enable = true;
    initrd.systemd.dbus.enable = true;
    resumeDevice = "/dev/disk/by-uuid/539e1e37-72a1-47b4-add9-d4eb2cc6c398";
    kernelParams = ["resume_offset=13223936"];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [
      "tcp_bbr"
    ];
    kernel = {
      sysctl = {
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.wmem_max" = 1073741824;
        "net.core.rmem_max" = 1073741824;
        "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
        "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
        "dev.tty.ldisc_autoload" = 0;
      };
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 12 * 1024; # 12GB in MB
    }
  ];

  systemd.user.services.niri-flake-polkit.enable = false;

  networking.hostName = "utkar"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [
    "127.0.0.1"
  ];
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_GB.UTF-8";

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

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.caskaydia-cove
    ];

    fontDir.enable = true;
  };

  xdg = {
    autostart = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          defaults = [
            "wlr"
            "gtk"
          ];
        };
      };
    };
  };

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/utkar/.config/sops/age/keys.txt";
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
    pki = {
      certificateFiles = ["${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"];
    };
  };

  systemd.user.targets = {
    mango-session.description = "MangoWC Session Target";
    mango-session.requires = ["graphical-session.target"];
    mango-session.after = ["graphical-session.target"];
  };
  systemd.user.tmpfiles.enable = true;
  systemd.tmpfiles.rules = [
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware}"
  ];

  # virtualisation.containers.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    libvirtd.dbus.enable = true;
    libvirtd.qemu = {
      runAsRoot = true;
      swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
    containers = {
      enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.utkar = {
    isNormalUser = true;
    description = "utkar";
    extraGroups = [
      "pihole"
      "aria2"
      "internet"
      "greeter"
      "pipewire"
      "libvirtd"
      "aria2"
      "flatpak"
      "networkmanager"
      "wheel"
      "podman"
      "libvirtd"
      "kvm"
      "video"
      "audio"
    ];
    packages = with pkgs; [
      hello
    ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = false;
        };
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg = {
    dirmngr.enable = true;
    agent = {
      enable = true;
      enableSSHSupport = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8888
    8080
    8000
    6800
    53
  ];
  networking.firewall.allowedUDPPorts = [53];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    channel.enable = false;
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "utkar"
      ];
      use-xdg-base-directories = true;
      builders-use-substitutes = true;
      auto-optimise-store = true;
      extra-substituters = [
        "https://watersucks.cachix.org"
        "https://yazi.cachix.org"
        "https://helix.cachix.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
      ];
      # trust the public key that signs that cache
      extra-trusted-public-keys = [
        "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
