{
  pkgs,
  lib,
  inputs,
  ...
}: let
  networkCheck = pkgs.writeShellScriptBin "network-check" ''
    #!${pkgs.bash}/bin/bash

    echo "Starting network monitor..."

    while true; do
      echo "Pinging 1.1.1.1..."

      if ${pkgs.iputils}/bin/ping -c 5 -W 2 1.1.1.1 > /dev/null 2>&1; then
        echo "Network available!"
        ${pkgs.libnotify}/bin/notify-send "network available"
        exit 0
      else
        echo "No network. Retrying in 7 seconds..."
        sleep 7
      fi
    done
  '';
in {
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
    inputs.alejandra.overlays.default
    inputs.nixd.overlays.default
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;
  environment.systemPackages = with pkgs; [
    # passExtensions.pass-import
    # gopass
    # gopass-hibp
    # gopass-jsonapi
    # nur.repos.Vortriz.surge
    winboat
    unzip
    jq
    networkCheck
    libnotify
    pkg-config
    nushell
    conky
    rich-cli
    yaziPlugins.ouch
    yaziPlugins.vcs-files
    yaziPlugins.no-status
    yaziPlugins.rich-preview
    yaziPlugins.lazygit
    yaziPlugins.yatline
    yaziPlugins.yatline-githead
    yaziPlugins.full-border
    yaziPlugins.mount
    yaziPlugins.recycle-bin
    trash-cli
    yaziPlugins.sudo
    yaziPlugins.diff
    yaziPlugins.rsync
    yaziPlugins.starship
    yaziPlugins.git
    yaziPlugins.jjui
    nur.repos.adam0.yaziPlugins.ucp
    python314Packages.aria2p
    imagemagick
    duf
    xcp
    gping
    curlie
    pwvucontrol
    mesa
    nautilus
    macchina
    lmstudio
    uv
    nur.repos.nakido.zellij-forgot
    alacritty
    nvd
    trash-cli
    fishPlugins.forgit
    fishPlugins.pisces
    fishPlugins.plugin-sudope
    fishPlugins.colored-man-pages
    fishPlugins.done
    fishPlugins.humantime-fish
    babelfish
    nur.repos.xddxdd.magiskboot
    gparted
    firefox
    ffmpeg-full
    srb2
    mindustry
    cacert
    devenv
    qemu_kvm
    qemu
    libvirt
    virt-manager
    taplo
    papirus-icon-theme
    tela-circle-icon-theme
    onlyoffice-desktopeditors
    ollama
    satty
    fcitx5
    bibata-cursors
    adw-gtk3
    xwayland-satellite-unstable
    libadwaita
    nirius
    ouch
    wl-clipboard
    gtk4
    gtk3
    btop
    gnome.gvfs
    wl-clip-persist
    greetd
    nur.repos.forkprince.helium-nightly
    kdePackages.qt6ct
    kdePackages.qt5compat
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kimageformats
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    qt6.qt5compat
    qt6.qtbase
    qt6.qtmultimedia
    krita
    kdePackages.kdenlive
    wineWow64Packages.waylandFull
    kdlfmt
    adwaita-icon-theme
    material-symbols
    material-icons
    vscode-json-languageserver
    podman-compose
    (lib.hiPrio uutils-coreutils-noprefix)
  ];
}
