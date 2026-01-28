{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-search-tv = {
    enable = true;
    package = inputs.nix-search-tv.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings.indexes = ["nixpkgs" "home-manager" "nixos" "nur"];
    enableTelevisionIntegration = true;
  };
}
