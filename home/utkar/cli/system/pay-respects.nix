{
  pkgs,
  inputs,
  ...
}: {
  programs.pay-respects = {
    enable = true;
    package = inputs.pay-respects.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
