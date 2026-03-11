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
      nur.repos.forkprince.proton-cachyos-v4-bin
    ];
    winePackages = [
      pkgs.wineWow64Packages.full
    ];
    protonPackages = with pkgs; [
      proton-ge-bin
      nur.repos.forkprince.proton-cachyos-v4-bin
    ];
  };
}
