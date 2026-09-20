{
  self,
  inputs,
  ...
}: {
  # disabledModules = ["programs/noctalia.nix"];
  imports =
    (with inputs; [
      nix-index-database.homeModules.nix-index
      dms.homeModules.dank-material-shell
      # inputs.dank-material-shell.homeModules.niri
      mango.hmModules.mango
      dux-search.homeModules.default
      nvf.homeManagerModules.default
      sops-nix.homeManagerModules.sops
      dux-plugin-registry.homeModules.default
      zen-browser.homeModules.twilight
      noctalia.homeModules.default
      stylix.homeModules.stylix
      optnix.homeModules.optnix
      yazelix-hm.homeManagerModules.default
      chaotic.homeManagerModules.default
      fetch.homeManagerModules.default
      umbriel.homeModules.default
    ])
    ++ [(inputs.import-tree ../../modules/home)];

  nixpkgs.overlays = self.nixosConfigurations.utkar.config.nixpkgs.overlays;
  nixpkgs.config = self.nixosConfigurations.utkar.config.nixpkgs.config;
  xdg.configFile."nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
  # nixpkgs.config.allowUnfree = true;
}
