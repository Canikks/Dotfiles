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
    protonPackages = [
      pkgs.proton-ge-bin
      pkgs.nur.repos.forkprince.proton-cachyos-v4-bin
    ];
  };
}
