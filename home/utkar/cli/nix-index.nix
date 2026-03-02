{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-index = {
    enable = true;
    package = inputs.nix-index-database.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
