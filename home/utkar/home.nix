{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    # inputs.zen-browser.homeModules.twilight
    ./shell/zsh.nix
    ./terminal/ghostty.nix
    ./editor/helix.nix
    ./file-manager/yazi.nix
    ./home-packages.nix
  ];
  home.stateVersion = "25.05";
  home.shell.enableZshIntegration = true;
  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;
    enableSystemSound = true;
    enableClipboard = true;
    enableSystemMonitoring = true;
    enableBrightnessControl = true;
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
  programs.fish.enable = true;
}
