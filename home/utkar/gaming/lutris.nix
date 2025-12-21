{pkgs, ...}: {
  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [
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
