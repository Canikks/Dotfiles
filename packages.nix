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
    firefox
    ffmpeg-full
    srb2
    mindustry-wayland
    gearlever
    ibus
    rio
    inputs.zen-test.packages.${pkgs.stdenv.hostPlatform.system}.twilight
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
    quickshell
    satty
    tealdeer
    wlr-randr
    fcitx5
    bibata-cursors
    # floorp-bin
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
    zed-editor
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
    podman
    greetd
    dbus
    dbus-broker
    nur.repos.forkprince.helium-nightly
    fastfetch
    lutris
    kdePackages.qt6ct
    wineWowPackages.waylandFull
    libGL
    vulkan-loader
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
