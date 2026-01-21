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
    ];
    protonPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
