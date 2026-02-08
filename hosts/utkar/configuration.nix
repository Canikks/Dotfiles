{
  pkgs,
  config,
  ...
}: {
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

  stylix.base16Scheme = "/home/utkar/.config/DankMaterialShell/base16.yaml";

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
    enableGhostscriptFonts = true;
    enableDefaultPackages = true;
    fontconfig = {
      subpixel.rgba = "rgb";
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
    ];
    fontDir.enable = true;
    fontDir.decompressFonts = true;
  };

  xdg = {
    autostart = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-termfilechooser
      ];
      config = {
        common = {
          defaults = [
            "kitty"
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
    age.generateKey = true;

    secrets.aria2_rpc_secret = {
      path = "/home/utkar/dotfiles/secrets/secret-rpc.txt.enc";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
    };

    secrets.netrc = {
      key = "netrc";
      owner = "root";
      group = "root";
      mode = "0400";
    };

    secrets.github_token = {
      key = "github_token";
      # path = "/home/utkar/github";
    };

    secrets.gitlab_token = {
      key = "gitlab_token";
    };

    secrets.ssh_id_ed25519 = {
      # path = "/run/secrets/ssh_id_ed25519";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
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
