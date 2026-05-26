{
  self,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # INPUT MODULES
    inputs.nix-index-database.homeModules.nix-index
    inputs.dank-material-shell.homeModules.dank-material-shell
    # inputs.dank-material-shell.homeModules.niri
    inputs.mango.hmModules.mango
    inputs.dsearch.homeModules.default
    inputs.nvf.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    inputs.dms-plugin-registry.modules.default
    inputs.zen-browser.homeModules.beta
    inputs.noctalia.homeModules.default
    inputs.stylix.homeModules.stylix
    inputs.optnix.homeModules.optnix
    inputs.yazelix-hm.homeManagerModules.default
    inputs.chaotic.homeManagerModules.default

    # LOCAL MODULES
    ../../modules/home/shell
    ../../modules/home/terminal
    ../../modules/home/editor
    ../../modules/home/apps
    ../../modules/home/file-manager
    ../../modules/home/cli
    ../../modules/home/browser
    ../../modules/home/gaming
    ../../modules/home/multiplexer
    ../../modules/home/audio
    ../../modules/home/desktop-shell
    ../../modules/home/core.nix
  ];

  nixpkgs.overlays = self.nixosConfigurations.utkar.config.nixpkgs.overlays;
  nixpkgs.config = self.nixosConfigurations.utkar.config.nixpkgs.config;
}