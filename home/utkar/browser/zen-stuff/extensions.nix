{
  inputs,
  pkgs,
  ...
}: {
  programs.zen-browser.profiles."Dw3oaFqL.Profile 1".extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
    darkreader
    ublock-origin
    keepassxc-browser
    zen-internet
    localcdn
    enhanced-h264ify
    sponsorblock
  ];
}
