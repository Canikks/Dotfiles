{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (prev.lixPackageSets.latest)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
    inputs.niri.overlays.niri
    inputs.nh.overlays.default
    inputs.ghostty.overlays.default
    inputs.rio.overlays.default
    inputs.alejandra.overlays.default
    inputs.nixd.overlays.default
    # inputs.yazi.overlays.default
    inputs.quickshell.overlays.default
    inputs.helix.overlays.default
    inputs.nix-your-shell.overlays.default
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;
  environment.systemPackages = with pkgs; [
    ddccontrol
    fprintd
    fishPlugins.forgit
    fishPlugins.pisces
    fishPlugins.fzf-fish
    fishPlugins.plugin-sudope
    fishPlugins.fifc
    babelfish
    nur.repos.xddxdd.magiskboot
    gparted
    # nodejs_20
    firefox
    ffmpeg-full
    # srb2
    mindustry-wayland
    gearlever
    (
      inputs.zen-browser.packages.${system}.beta-unwrapped.overrideAttrs
      (oldAttrs: rec {
        libName = "zen-bin-1.17.15b";
        fsautoconfig = (
          builtins.fetchurl {
            url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
            sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
          }
        );
        configpref = (
          builtins.fetchurl {
            url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/refs/heads/master/program/defaults/pref/config-prefs.js";
            sha256 = "sha256-a/0u0TnRj/UXjg/GKjtAWFQN2+ujrckSwNae23DBfs4=";
          }
        );

        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            chmod -R u+w "$out/lib/${libName}"
            cp "${(builtins.trace fsautoconfig fsautoconfig)}" "$out/lib/${libName}/config.js"
            mkdir -p "$out/lib/${libName}/defaults/pref"
            cp "${configpref}" "$out/lib/${libName}/defaults/pref/config-pref.js"
          '';
      })
    )
    cacert
    devenv
    qemu_kvm
    qemu
    libvirt
    virt-manager
    easyeffects
    taplo
    papirus-icon-theme
    starship
    onlyoffice-desktopeditors
    ollama
    opencode
    satty
    tealdeer
    fcitx5
    bibata-cursors
    adw-gtk3
    ghostty
    niri-unstable
    xwayland-satellite-unstable
    libadwaita
    nirius
    ouch
    tmux
    eza
    wl-clipboard
    (lib.hiPrio pkgs.wl-clipboard-rs)
    nh
    (yazi.override {
      _7zz = pkgs._7zz-rar;
    })
    gtk4
    gtk3
    btop
    gnome.gvfs
    fzf
    ripgrep
    wl-clip-persist
    greetd
    dbus-broker
    nur.repos.forkprince.helium-nightly
    fastfetch
    kdePackages.qt6ct
    wineWowPackages.waylandFull
    keepassxc
    kdlfmt
    adwaita-icon-theme
    material-symbols
    material-icons
    fd
    vscode-json-languageserver
    # (lib.hiPrio pkgs.uutils-coreutils-noprefix)
    quickshell
  ];
}
