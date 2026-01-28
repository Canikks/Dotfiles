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
    # inputs.nh.overlays.default
    # inputs.ghostty.overlays.default
    # inputs.rio.overlays.default
    inputs.alejandra.overlays.default
    inputs.nixd.overlays.default
    # inputs.yazi.overlays.default
    # inputs.quickshell.overlays.default
    # inputs.helix.overlays.default
    inputs.nix-your-shell.overlays.default
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;
  environment.systemPackages = with pkgs; [
    # passExtensions.pass-import
    # gopass
    # gopass-hibp
    # gopass-jsonapi
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
    python314Packages.aria2p
    imagemagick
    lazyjj
    duf
    pwvucontrol
    pavucontrol
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
    mindustry-wayland
    (
      inputs.zen-browser.packages.${system}.twilight-unwrapped.overrideAttrs
      (oldAttrs: rec {
        libNameGlob = "zen-bin-*";
        fsautoconfig = (
          builtins.fetchurl {
            url = "https://raw.githubusercontent.com/sineorg/bootloader/main/program/config.js";
            sha256 = "117a6gkaz1kinjflfzqc6qsb4r06x93w08q4lfdzh5a1cng95s5v";
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
            for libdir in "$out"/lib/${libNameGlob}; do
              chmod -R u+w "$libdir"
              cp "${fsautoconfig}" "$libdir/config.js"
              mkdir -p "$libdir/defaults/pref"
              cp "${configpref}" "$libdir/defaults/pref/config-pref.js"
            done
          '';
      })
    )
    cacert
    devenv
    qemu_kvm
    qemu
    libvirt
    virt-manager
    taplo
    papirus-icon-theme
    starship
    onlyoffice-desktopeditors
    ollama
    opencode
    satty
    fcitx5
    bibata-cursors
    adw-gtk3
    # ghostty
    xwayland-satellite-unstable
    libadwaita
    nirius
    ouch
    wl-clipboard
    (lib.hiPrio pkgs.wl-clipboard-rs)
    # (yazi.override {
    #   _7zz = pkgs._7zz-rar;
    # })
    gtk4
    gtk3
    btop
    gnome.gvfs
    wl-clip-persist
    greetd
    nur.repos.forkprince.helium-nightly
    fastfetch
    kdePackages.qt6ct
    kdePackages.qt5compat
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    wineWowPackages.waylandFull
    kdlfmt
    adwaita-icon-theme
    material-symbols
    material-icons
    vscode-json-languageserver
    # quickshell
    podman-compose
    (lib.hiPrio uutils-coreutils-noprefix)
  ];
}
