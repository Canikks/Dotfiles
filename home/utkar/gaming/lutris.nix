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
      gamescope
      gamemode
    ];
    protonPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
