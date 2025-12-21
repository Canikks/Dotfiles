{...}: {
  programs.zellij = {
    enable = true;
    # enableZshIntegration = true;
    enableFishIntegration = true;
    # attachExistingSession = true;
  };
  # xdg.configFile."zellij/layouts/default.kdl" = {
  #   source = ./slanted.kdl;
  # };
  # xdg.configFile."zellij/layouts/conky.conf" = {
  #   source = ./conky.conf;
  # };
}
