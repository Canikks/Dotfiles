# Shared list of Home Manager input modules used by both:
#   - home.nix (imports)
#   - hosts/utkar/programs.nix (optnix scopes)
#
# Pass { inputs } from the calling file.
{inputs}:
with inputs; [
  nix-index-database.homeModules.nix-index
  dank-material-shell.homeModules.dank-material-shell
  mango.hmModules.mango
  dsearch.homeModules.default
  nvf.homeManagerModules.default
  sops-nix.homeManagerModules.sops
  dms-plugin-registry.modules.default
  zen-browser.homeModules.twilight
  noctalia.homeModules.default
  stylix.homeModules.stylix
  optnix.homeModules.optnix
  yazelix-hm.homeManagerModules.default
  nyx-loner.homeManagerModules.default
]
