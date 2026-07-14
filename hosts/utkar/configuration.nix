{
  self,
  inputs,
  ...
}: {
  imports = [
    (inputs.import-tree ../../modules/nixos)
    (import ./hardware-configuration.nix)
  ];
}
