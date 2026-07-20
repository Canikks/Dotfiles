{
  self,
  inputs,
  ...
}: {
  imports =
    (with inputs; [
      nix-index-database.homeModules.nix-index
      dank-material-shell.homeModules.dank-material-shell
      # inputs.dank-material-shell.homeModules.niri
      mango.hmModules.mango
      dsearch.homeModules.default
      nvf.homeManagerModules.default
      sops-nix.homeManagerModules.sops
      dms-plugin-registry.homeModules.default
      zen-browser.homeModules.twilight
      noctalia.homeModules.default
      stylix.homeModules.stylix
      optnix.homeModules.optnix
      yazelix-hm.homeManagerModules.default
      chaotic.homeManagerModules.default
      fetch.homeManagerModules.default
    ])
    ++ [(inputs.import-tree ../../modules/home)];

  nixpkgs.overlays = self.nixosConfigurations.utkar.config.nixpkgs.overlays;
  nixpkgs.config = self.nixosConfigurations.utkar.config.nixpkgs.config;
  # nixpkgs.config.allowUnfree = true;
}
