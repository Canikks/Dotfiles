{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.mango.hmModules.mango
    # inputs.zen-browser.homeModules.twilight
    ./shell/zsh.nix
    ./terminal/ghostty.nix
    ./editor/helix.nix
    ./file-manager/yazi.nix
    ./home-packages.nix
  ];
  # home.packages = [
  #   inputs.sine-zen-test.packages.x86_64-linux.twilight
  # ];
  home.stateVersion = "25.05";
  home.shell.enableZshIntegration = true;
  nixpkgs.config = {
    allowUnfree = true;
  };

  wayland.windowManager.mango = {
    enable = true;
    # systemd.enable = true;
    # autostart_sh = ''
    #   dms run
    # '';
  };

  programs.dankMaterialShell = {
    enable = true;
    # systemd.enable = true;
    enableSystemSound = true;
    enableClipboard = true;
    enableSystemMonitoring = true;
    enableBrightnessControl = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableColorPicker = true;
    quickshell.package = inputs.quickshell.packages.x86_64-linux.default;
  };
  programs.nix-search-tv.enableTelevisionIntegration = true;
  programs.home-manager.enable = true;
  xdg.autostart = {
    enable = true;
  };
  programs.keepassxc = {
    enable = true;
    autostart = true;
  };
  programs.tealdeer = {
    settings = {
      updates = {
        auto_update = true;
      };
    };
  };

  programs.fish.enable = true;
  # Provide SSH key files declaratively
  # home.file.".ssh/id_ed25519".source = /home/utkar/.dotfiles/keys/id_ed25519;
  # home.file.".ssh/id_ed25519.pub".source = /home/utkar/.dotfiles/keys/id_ed25519.pub;

  # Optional: ensure correct permissions
  # home.file.".ssh/id_ed25519".permissions = "0600";
  # home.file.".ssh/id_ed25519.pub".permissions = "0644";
}
