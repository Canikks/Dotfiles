{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-search-tv = {
    enable = false;
    package = inputs.nix-search-tv.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableTelevisionIntegration = true;
    settings = {
      indexes = ["nixpkgs" "nur" "noogle"];
      update_interval = "6h";
      # experimental.options_file = {
      #   # render_docs_indexes = {
      #   nvf = "https://nvf.notashelf.dev/options.html";
      #   # };
      # };
    };
  };
}
