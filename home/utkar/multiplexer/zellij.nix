{...}: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    attachExistingSession = true;
    exitShellOnExit = true;
  };
  # xdg.configFile."zellij/layouts/conky.conf" = {
  #   source = ./conky.conf;
  # };
  # xdg.configFile."zellij/layouts/default.kdl" = {
  #   source = ./slanted.kdl;
  # };
}
