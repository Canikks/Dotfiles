{
  pkgs,
  # inputs,
  ...
}: {
  imports = [
    ./zen-stuff
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
