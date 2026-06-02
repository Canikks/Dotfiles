{
  self,
  inputs,
  pkgs,
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
      dms-plugin-registry.modules.default
      zen-browser.homeModules.beta
      noctalia.homeModules.default
      stylix.homeModules.stylix
      optnix.homeModules.optnix
      yazelix-hm.homeManagerModules.default
      chaotic.homeManagerModules.default
    ])
    ++ (with self.homeModules; [
      shell
      terminal
      editor
      apps
      file-manager
      cli
      browser
      gaming
      multiplexer
      audio
      desktop-shell
      core
    ]);

  nixpkgs.overlays = self.nixosConfigurations.utkar.config.nixpkgs.overlays;
  nixpkgs.config = self.nixosConfigurations.utkar.config.nixpkgs.config;
}
