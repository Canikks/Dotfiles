{ inputs, self, system, pkgs, ... }: {
  home-manager.useGlobalPkgs = false;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";
  home-manager.extraSpecialArgs = { inherit inputs self system; };
  home-manager.users.utkar = import ../../home/utkar/home.nix;
  home-manager.startAsUserService = true;
  home-manager.verbose = true;
  home-manager.backupCommand = "${pkgs.trash-cli}/bin/trash";
  home-manager.overwriteBackup = true;
}
