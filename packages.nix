{
  pkgs,
  lib,
  # niri,
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
    inputs.ghostty.overlays.releasefast
    inputs.alejandra.overlays.default
    inputs.nixd.overlays.default
    inputs.yazi.overlays.default
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;
  environment.systemPackages = with pkgs; [
    appimage-run
    hicolor-icon-theme
    papirus-icon-theme
    adw-gtk3
    xdg-desktop-portal-termfilechooser
    ghostty
    pkgs.niri-unstable
    localsend
    libadwaita
    unrar
    inteltool
    nushell
    go
    nirius
    vimPlugins.nvim-treesitter-parsers.nix
    vimPlugins.nvim-treesitter.builtGrammars.nix
    ouch
    tmux
    eza
    wl-clipboard
    (lib.hiPrio pkgs.wl-clipboard-rs)
    nh
    (yazi.override {
      _7zz = pkgs._7zz-rar;
    })
    nil
    cmake
    zed-editor-fhs
    wget
    neovim
    firefox
    mesa-demos
    alacritty
    gtk4
    gtk3
    nautilus
    colloid-gtk-theme
    polkit_gnome
    btop
    gnome.gvfs
    nautilus-python
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-completions
    fzf
    zsh-syntax-highlighting
    ripgrep
    alejandra
    nixd
    wl-clip-persist
    podman
    greetd
    dbus
    dbus-broker
    nur.repos.Ev357.helium
    fastfetch
    kdePackages.qtmultimedia
    lutris
    kdePackages.qt6ct
    gamescope
    wineWowPackages.waylandFull
    xwayland-satellite
    libx11
    libxkbcommon
    libGL
    vulkan-loader
    vulkan-tools
    srb2
    keepassxc
    kdlfmt
    adwaita-icon-theme
    material-symbols
    material-icons
    aria2
    ariang
    fd
    inputs.nix-search-tv.packages.${pkgs.stdenv.hostPlatform.system}.default
    vscode-json-languageserver
    # (lib.hiPrio pkgs.uutils-coreutils-noprefix)
    upower
  ];
}
