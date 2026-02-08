{
  inputs,
  pkgs,
  ...
}: {
  programs.jjui = {
    enable = true;
    package = inputs.jjui.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
