{
  inputs,
  self,
  system,
  pkgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs self system;};
    users.utkar = import ../../home/utkar/home.nix;
    startAsUserService = true;
    verbose = true;
    backupCommand = "${pkgs.trash-cli}/bin/trash";
    overwriteBackup = true;
  };
}
