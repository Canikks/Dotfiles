{
  pkgs,
  lib,
  # niri,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
    # niri.overlays.niri
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  environment.systemPackages = with pkgs; [
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
    yazi
    nil
    cmake
    zed-editor-fhs
    wget
    neovim
    firefox
    mesa-demos
    alacritty
    gtk4
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
    distrobox
    distrobox-tui
    podman
    boxbuddy
    greetd
    dbus
    dbus-broker
    nur.repos.Ev357.helium
    fastfetch
    kdePackages.qtmultimedia
    libsForQt5.qt5.qtmultimedia
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
    nix-search-tv
    vscode-json-languageserver
    # (lib.hiPrio pkgs.uutils-coreutils-noprefix)
    upower
  ];
}
