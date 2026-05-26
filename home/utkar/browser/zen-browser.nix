{
  pkgs,
  # inputs,
  ...
}: let
  profileName = "Dw3oaFqL.Profile 1";
in{
  imports = [
    ./zen-stuff
  ];
  _module.args = {
    inherit profileName;
  };
  programs.zen-browser = {
    enable = true;
    profiles = {
      ${profileName} = {
        sine.enable = true;
        containersForce = true;
        spacesForce = true;
      };
    };
    nativeMessagingHosts = [pkgs.firefoxpwa];
  };
}
