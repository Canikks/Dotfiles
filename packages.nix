{
  pkgs,
  lib,
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
    # (final: prev: {
    #   allegro = prev.allegro.overrideAttrs (old: {
    #     cmakeFlags = (old.cmakeFlags or []) ++ ["-DCMAKE_POLICY_VERSION_MINIMUM=3.5"];
    #   });
    # })
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  environment.systemPackages = with pkgs; [
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
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    firefox
    mesa-demos
    alacritty
    # kdePackages.dolphin
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
    kitty
    ripgrep
    (brave.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    })
    nixfmt
    alejandra
    nixd
    # wl-clipboard-rs
    wl-clip-persist
    distrobox
    distrobox-tui
    podman
    boxbuddy
    # tuigreet
    greetd
    dbus
    dbus-broker
    # ghostty
    # ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    ripgrep
    nix-search-tv
    vscode-json-languageserver
    # quickshell
    # (lib.hiPrio pkgs.uutils-coreutils-noprefix)
    # gitoxide
    upower
  ];
}
