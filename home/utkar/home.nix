{
  inputs,
  # pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.zen-browser.homeModules.twilight
    ./shell/zsh.nix
    ./terminal/ghostty.nix
    ./editor/helix.nix
    ./file-manager/yazi.nix
  ];
  home.stateVersion = "25.05";
  nixpkgs.config = {
    allowUnfree = true;
  };
  gtk = {
    gtk3 = {
      extraConfig = {
        gtk-theme-name = "Colloid";
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-theme-name = "Colloid";
      };
    };
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
  programs.dankMaterialShell.enable = true;
}
