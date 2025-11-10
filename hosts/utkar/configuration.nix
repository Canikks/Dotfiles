# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ../../modules/programs.nix
    ../../modules/services.nix
    ../../modules/environment.nix
    # ../../packages.nix
    ../../hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelModules = ["intel_pstate" "msr" "coretemp"];
  };

  networking.hostName = "utkar"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = ["1.1.1.1" "9.9.9.9"];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Set the default locale to English (India) with UTF-8 encoding
  i18n.defaultLocale = "en_GB.UTF-8";

  # Ensure en_IN.UTF-8 locale is supported by glibc

  # stylix = {
  #   enable = true;
  #   image = ../../Pictures/nebula-thumb.jpg;
  #   polarity = "dark";
  # };

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
    };
  };

  security = {
    polkit = {
      enable = true;
      # package = pkgs.mate.mate-polkit;
    };
    rtkit = {
      enable = true;
    };
    sudo-rs = {
      enable = true;
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware = {
    cpu = {
      intel = {
        updateMicrocode = true;
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
        vaapi-intel-hybrid
        libva
        libva-vdpau-driver
        intel-vaapi-driver
        vpl-gpu-rt
        intel-media-driver
        intel-compute-runtime-legacy1
      ];
    };
    bluetooth = {
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
  };

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

  # nix.settings.experimental-features = [
  #   "nix-command"
  #   "flakes"
  # ];

  nix.settings = {
    extra-substituters = ["https://yazi.cachix.org"];

    # trust the public key that signs that cache
    extra-trusted-public-keys = [
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
