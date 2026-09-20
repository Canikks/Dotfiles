{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    attachExistingSession = false;
    exitShellOnExit = false;
    # plugins = with pkgs.zellijPlugins; [jbz zjstatus zjframes];
    # settings = {
    #   default_mode = "locked";
    #   # default_layout = "compact";
    #   # theme = "noctalia";
    # };
  };
  # xdg.configFile."zellij/layouts/conky.conf" = {
  #   source = ./conky.conf;
  # };
  # xdg.configFile."zellij/layouts/default.kdl" = {
  #   source = ./slanted.kdl;
  # };
}
