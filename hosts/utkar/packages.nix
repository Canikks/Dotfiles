{
  pkgs,
  lib,
  inputs,
  ...
}: let
  ocrScreenshot = pkgs.writeShellScriptBin "ocr-screenshot" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    dms screenshot | tesseract stdin stdout | dms cl copy
  '';
  noctaliaTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "sddm-noctalia-theme";
    version = "unstable";
    src = inputs.sddm-noctalia;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/sddm/themes/sddm
      cp -r . $out/share/sddm/themes/sddm/
      runHook postInstall
    '';
  };
  ns = pkgs.writeShellApplication {
    name = "ns";
    runtimeInputs = with pkgs; [
      fzf
      nix-search-tv
    ];
    text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
  };
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
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
    inputs.quickshell.overlays.default
    inputs.niri.overlays.niri
    inputs.hyprland.overlays.default
    inputs.alejandra.overlays.default
    inputs.nixd.overlays.default
    inputs.nix-cachyos-kernel.overlays.pinned
    inputs.millennium.overlays.default
    inputs.nh.overlays.default
    inputs.jj-starship.overlays.default
    inputs.quickemu.overlays.default
    inputs.devenv.overlays.default
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;

  environment.systemPackages = with pkgs; [
    # --- Core System & Utilities ---
    wtype
    btrfs-progs
    btrfs-assistant
    brightnessctl
    ddcutil
    ddcutil-service
    evtest
    btop
    duf
    gping
    curlie
    conky
    xcp
    unzip
    jq
    libnotify
    pkg-config
    wl-clipboard
    wl-clip-persist
    trash-cli
    ouch-rar
    cacert
    greetd
    gnome.gvfs
    (lib.hiPrio uutils-coreutils-noprefix)
    gdu
    quickemu
    ns
    acpi
    acpid
    acpic

    # --- Development & CLI Tools ---
    python3
    uv
    nushell
    devenv
    tesseract
    translate-shell
    slurp
    grim
    ocrScreenshot
    rich-cli
    nvd
    dix
    vscode-json-languageserver
    podman-compose
    jj-starship
    tree

    # --- GUI Applications ---
    vivaldi
    firefox
    handbrake
    onlyoffice-desktopeditors
    lmstudio
    gparted
    nautilus
    macchina
    satty
    virt-manager

    # --- Gaming & Emulation ---
    glfw3-minecraft
    openal
    mangohud
    srb2
    mindustry
    wineWow64Packages.waylandFull

    # --- Multimedia & Graphics ---
    # ffmpeg-full
    imagemagick
    pwvucontrol
    cbonsai
    ueberzugpp

    # --- Virtualization & Containers ---
    qemu_kvm
    qemu
    libvirt
    virtio-win
    ollama-cpu

    # --- Themes, Icons & Appearance ---
    colloid-gtk-theme
    lxappearance
    nwg-look
    papirus-icon-theme
    adwaita-icon-theme
    bibata-cursors
    adw-gtk3
    libadwaita
    material-symbols
    material-icons
    libsForQt5.qt5ct
    qt6Packages.qt6ct

    # --- Desktop Environment / Wayland / Qt6 ---
    xdg-desktop-portal-termfilechooser
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    gtk4
    gtk3
    qt6.qt5compat
    qt6.qtbase
    qt6.qtmultimedia
    qt5.qtbase
    # inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable
    xwayland-satellite-unstable
    nirius
    alacritty

    # --- KDE Applications ---
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kimageformats

    # --- Shell Plugins (Fish) ---
    fishPlugins.puffer
    fishPlugins.fifc
    fishPlugins.fish-bd
    fishPlugins.forgit
    fishPlugins.pisces
    fishPlugins.plugin-sudope
    fishPlugins.colored-man-pages
    fishPlugins.done
    fishPlugins.humantime-fish
    zsh-abbr
    babelfish

    # --- Yazi Plugins ---
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
    yaziPlugins.sudo
    yaziPlugins.diff
    yaziPlugins.rsync
    yaziPlugins.starship
    yaziPlugins.git
    yaziPlugins.jjui
    yaziPlugins.chmod

    # --- Others & Custom Repos ---
    app2unit
    runapp
    nur.repos.lonerOrz.helium
    # nur.repos.nakido.zellij-forgot
    # nur.repos.xddxdd.magiskboot
    # python314Packages.aria2p
    fcitx5
  ];
}
