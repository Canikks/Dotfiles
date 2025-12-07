{
  config,
  pkgs,
  ...
}: {
  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [
      mangohud
      umu-launcher
      proton-cachyos
      gamescope_git
      gamemode
      srb2
    ];
    protonPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
