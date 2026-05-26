{
  inputs,
  pkgs,
  profileName,
  ...
}: {
  programs.zen-browser.profiles.${profileName}.extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
    adnauseam
    darkreader
    ublock-origin
    keepassxc-browser
    zen-internet
    localcdn
    enhanced-h264ify
    sponsorblock
    gopass-bridge
  ];
}
