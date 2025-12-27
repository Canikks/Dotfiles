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
    # inputs.quickshell.overlays.default
    inputs.helix.overlays.default
    inputs.nix-your-shell.overlays.default
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;
  environment.systemPackages = with pkgs; [
    fishPlugins.forgit
    fishPlugins.pisces
    fishPlugins.fzf-fish
    fishPlugins.plugin-sudope
    babelfish
    nur.repos.xddxdd.magiskboot
    gparted
    nodejs_20
    firefox
    ffmpeg-full
    srb2
    mindustry-wayland
    gearlever
    ibus
    inputs.zen-test.packages.${pkgs.stdenv.hostPlatform.system}.beta
    lsp-plugins
    zam-plugins
    calf
    mda_lv2
    aria2
    cacert
    devenv
    qemu_kvm
    qemu
    libvirt
    virt-manager
    easyeffects
    taplo
    lazygit
    papirus-icon-theme
    starship
    onlyoffice-desktopeditors
    ollama
    opencode
    satty
    tealdeer
    wlr-randr
    fcitx5
    bibata-cursors
    adw-gtk3
    ghostty
    niri-unstable
    xwayland-satellite-unstable
    libadwaita
    nushell
    go
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
    # zed-editor
    mesa-demos
    gtk4
    gtk3
    nautilus
    btop
    gnome.gvfs
    fzf
    ripgrep
    alejandra
    nixd
    wl-clip-persist
    greetd
    dbus
    dbus-broker
    nur.repos.forkprince.helium-nightly
    fastfetch
    lutris
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
  ];
}
