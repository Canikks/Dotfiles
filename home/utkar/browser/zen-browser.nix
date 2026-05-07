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
  ];
  programs.zen-browser = {
    enable = true;
    profiles = {
      "Dw3oaFqL.Profile 1" = {
        sine.enable = true;
      };
    };
    nativeMessagingHosts = [pkgs.firefoxpwa];
  };
}
