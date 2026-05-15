{
  pkgs,
  # inputs,
  ...
}: {
  imports = [
    ./zen-stuff/extensions.nix
    ./zen-stuff/mods.nix
    ./zen-stuff/pref.nix
    ./zen-stuff/search-engine.nix
    ./zen-stuff/containers.nix
    ./zen-stuff/spaces.nix
    ./zen-stuff/zen-personal.nix
    ./zen-stuff/zen-reddit.nix
    ./zen-stuff/zen-nix.nix
    ./zen-stuff/zen-ai.nix
    ./zen-stuff/zen-pirate.nix
  ];
  programs.zen-browser = {
    enable = true;
    profiles = {
      "Dw3oaFqL.Profile 1" = {
        sine.enable = true;
        containersForce = true;
        spacesForce = true;
      };
    };
    nativeMessagingHosts = [pkgs.firefoxpwa];
  };
}
