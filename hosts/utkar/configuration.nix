{pkgs, ...}: {
  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./environment.nix
    ./hardware-configuration.nix
    ./network.nix
    ./hardware.nix
    ./boot.nix
    ./virtualisation.nix
    ./nix.nix
    ./systemd.nix
  ];
  swapDevices = [
    {
      device = "/dev/disk/by-label/nix-swap";
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

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
      nerd-fonts.meslo-lg
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

    secrets.aria2_rpc_secret = {
      path = "/home/utkar/dotfiles/secrets/secret-rpc.txt.enc";
    };

    secrets.github_token = {
      key = "github_token";
    };

    secrets.gitlab_token = {
      key = "gitlab_token";
    };

    secrets.ssh_id_ed25519 = {
      path = "/run/secrets/ssh_id_ed25519";
      owner = "utkar";
      group = "users";
      mode = "0600";
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
    pki = {
      certificateFiles = ["${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"];
    };
  };

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

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
