{config, pkgs, ...}: {
  programs.lutris = {
    enable = true;
    # extraPackages = [
    #   pkgs.mangohud
    # ];
    protonPackages = [
      pkgs.proton-ge-bin
      pkgs.proton-cachyos
      pkgs.proton-cachyos_x86_64_v4
    ];
  };
}
