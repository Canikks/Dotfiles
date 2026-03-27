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

  # system.etc.overlay.enable = true;
  # system.nixos-init.enable = true;

  appstream.enable = true;

  swapDevices = [
    {
      device = "/dev/disk/by-label/nix-swap";
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  stylix.base16Scheme = "${config.users.users.utkar.home}/.config/DankMaterialShell/base16.yaml";

  time.timeZone = "Asia/Kolkata";

  location.provider = "geoclue2";

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
    terminal-exec = {
      enable = true;
      settings = {
        GNOME = [
          "com.raggesilver.BlackBox.desktop"
          "org.gnome.Terminal.desktop"
        ];
        default = [
          "kitty.desktop"
        ];
      };
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-termfilechooser
      ];
      config = {
        # niri = {
        #   default = [
        #     "termfilechooser"
        #   ];
        # };
        common = {
          default = [
            "gnome"
            "gtk"
          ];
          # "org.freedesktop.impl.portal.FileChooser" = [
          #   "termfilechooser"
          # ];
        };
      };
    };
  };

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    useTmpfs = true;
    age.keyFile = "${config.users.users.utkar.home}/.config/sops/age/keys.txt";
    age.generateKey = true;

    # secrets.aria2_rpc_secret = {
    # path = "/home/utkar/dotfiles/secrets/secret-rpc.txt.enc";
    # owner = "aria2";
    # group = config.users.users.utkar.group;
    # };

    secrets.netrc = {
      key = "netrc";
      owner = "root";
      group = "root";
      mode = "0400";
    };

    secrets.github_token = {
      key = "github_token";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
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
      adminIdentities = ["unix-user:utkar" "unix-group:users"];
      extraConfig = "/* Log authorization checks. */\npolkit.addRule(function(action, subject) {\n  // Make sure to set { security.polkit.debug = true; } in configuration.nix\n  polkit.log(\"user \" +  subject.user + \" is attempting action \" + action.id + \" from PID \" + subject.pid);\n});\n\n/* Allow any local user to do anything (dangerous!). */\npolkit.addRule(function(action, subject) {\n  if (subject.local) return \"yes\";\n});\n";
    };
    tpm2 = {
      enable = true;
      abrmd.enable = true;
      pkcs11.enable = true;

      tctiEnvironment.enable = true;
      tctiEnvironment.interface = "tabrmd";
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
    unprivilegedUsernsClone = true;
  };

  users.users.utkar = {
    linger = true;
    isNormalUser = true;
    name = "utkar";
    autoSubUidGidRange = true;
    description = "utkar";
    extraGroups = [
      "docker"
      "pihole"
      "aria2"
      "internet"
      "greeter"
      "pipewire"
      "libvirtd"
      "qemu-libvirtd"
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
