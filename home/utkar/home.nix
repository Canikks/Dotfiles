{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.mango.hmModules.mango
    ./shell/zsh.nix
    ./terminal/ghostty.nix
    ./editor/helix.nix
    ./file-manager/yazi.nix
    ./home-packages.nix
    ./shell/prompt/starship.nix
  ];
  home.stateVersion = "25.05";
  home.shell.enableZshIntegration = true;
  nixpkgs.config = {
    allowUnfree = true;
  };

  wayland.windowManager.mango = {
    enable = true;
  };

  programs.dankMaterialShell = {
    enable = true;
    niri = {
      enableSpawn = true;
    };
    # systemd = {
    #   enable = true;
    #   restartIfChanged = true;
    # };
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
}
