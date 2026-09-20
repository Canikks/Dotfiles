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
    # (_: prev: {
    #   openldap = prev.openldap.overrideAttrs {
    #     doCheck = !prev.stdenv.hostPlatform.isi686;
    #   };
    # })
    # inputs.quickshell.overlays.default
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
    inputs.nix-minecraft.overlay
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
    libinput
    libinput-gestures
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
    # quickemu
    ns
    acpi
    acpid
    acpic
    hydra-check
    moor
    intel-cmt-cat
    freetype
    udev
    sshfs
    scrcpy
    tmux
    nvtopPackages.intel
    inputs.nix-graph.packages.${pkgs.stdenv.hostPlatform.system}.nix-graph
    inputs.zmx.packages.${pkgs.stdenv.hostPlatform.system}.zmx
    # zmx
    # gopeed
    efibootmgr

    # --- Development & CLI Tools ---
    python3
    uv
    nushell
    devenv
    # nixd
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
    gopass
    gopass-jsonapi
    tree-sitter
    alejandra
    # nur.repos.lonerOrz.surge
    sops
    nix-zsh-completions
    lua-language-server
    stylua

    # --- GUI Applications ---
    vivaldi
    firefox
    # handbrake
    lmstudio
    nautilus
    macchina
    satty
    virt-manager
    gimp

    # --- Gaming & Emulation ---
    mangohud
    # mindustry
    wineWow64Packages.waylandFull

    # --- Multimedia & Graphics ---
    ffmpeg-full
    imagemagick
    pwvucontrol
    cbonsai
    ueberzugpp

    # --- Virtualization & Containers ---
    qemu_kvm
    qemu
    libvirt
    virtio-win

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
    # libsForQt5.qtwayland
    # kdePackages.qt5compat
    kdePackages.qt6ct
    kdePackages.qt5compat
    kdePackages.qtwayland
    kdePackages.kdialog
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum

    # --- Desktop Environment / Wayland / Qt6 ---
    xdg-desktop-portal-termfilechooser
    # nur.repos.Vortriz.xdg-desktop-portal-termfilechooser
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    gtk4
    gtk3
    # qt6.qt5compat
    # qt6.qtbase
    # qt6.qtmultimedia
    # qt5.qtbase
    # inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable
    xwayland-satellite-unstable
    nirius
    alacritty

    # --- KDE Applications ---
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kimageformats
    kdePackages.oxygen
    kdePackages.oxygen.qt5
    kdePackages.oxygen-icons

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

    # --- Others & Custom Repos ---
    app2unit
    runapp
    nur.repos.davinci42.fluxdown-server
    # nur.repos.lonerOrz.helium
    # inputs.tauritavern.packages.${pkgs.stdenv.hostPlatform.system}.canary
    # azahar
    # nur.repos.dmfrpro.spflashtool5
    # fcitx5
  ];
}
