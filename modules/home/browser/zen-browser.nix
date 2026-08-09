{pkgs, ...}: let
  profileName = "default";
in {
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
        pinsForce = true;
        presets.betterfox.enable = true;
        # nativeMessagingHosts = [
        #   pkgs.nur.repos.colinsane.gopass-native-messaging-host
        # ];
      };
    };
    nativeMessagingHosts = [pkgs.firefoxpwa];
  };
}
