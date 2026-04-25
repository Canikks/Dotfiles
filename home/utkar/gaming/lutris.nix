{
  pkgs,
  inputs,
  ...
}: {
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
      nur.repos.vladexa.proton-cachyos-v3
    ];
    winePackages = [
      pkgs.wineWow64Packages.full
    ];
    protonPackages = with pkgs; [
      proton-ge-bin
      nur.repos.vladexa.proton-cachyos-v3
    ];
  };
}
