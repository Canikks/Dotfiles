{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-your-shell = {
    enable = true;
    package = inputs.nys.packages.${pkgs.stdenv.hostPlatform.system}.default;
    nix-output-monitor.enable = true;
  };
}
