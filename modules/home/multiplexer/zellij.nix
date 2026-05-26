{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    attachExistingSession = false;
    exitShellOnExit = false;
  };
  # xdg.configFile."zellij/layouts/conky.conf" = {
  #   source = ./conky.conf;
  # };
  # xdg.configFile."zellij/layouts/default.kdl" = {
  #   source = ./slanted.kdl;
  # };
}
