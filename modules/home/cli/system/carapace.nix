{pkgs, ...}: {
  programs.carapace = {
    enable = true;
    enableFishIntegration = false;
    extraPackages = with pkgs; [
      inshellisense
    ];
    environment = {
      CARAPACE_BRIDGES = "zsh,fish,bash";
      CARAPACE_MATCH = true;
    };
  };
}
