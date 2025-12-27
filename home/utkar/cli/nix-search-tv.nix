{...}: {
  programs.nix-search-tv = {
    enable = true;
    settings.indexes = ["nixpkgs" "home-manager" "nixos" "nur"];
  };
}
