{pkgs, ...}: {
  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [
      winetricks
      mangohud
      umu-launcher
      gamescope
      gamemode
      vulkan-tools
      xrandr
    ];
    winePackages = [
      pkgs.wineWow64Packages.full
    ];
    # protonPackages = [
    #   pkgs.proton-ge-bin
    # ];
  };
}
