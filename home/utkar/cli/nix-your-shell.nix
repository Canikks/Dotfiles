{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-your-shell = {
    enable = true;
    package = inputs.nix-your-shell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableFishIntegration = true;
    nix-output-monitor.enable = true;
  };
}
