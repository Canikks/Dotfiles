{...}: {
  programs.nix-your-shell = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    nix-output-monitor.enable = true;
  };
}
