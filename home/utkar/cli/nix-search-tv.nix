{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-search-tv = {
    enable = true;
    package = inputs.nix-search-tv.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableTelevisionIntegration = true;
    settings = {
      indexes = ["nixpkgs" "home-manager" "nixos" "nur"];
      # experimental = {
      #   render_docs_indexes = {
      #     nvf = "https://nvf.notashelf.dev/options.html";
      #   };
      # };
    };
  };
}
