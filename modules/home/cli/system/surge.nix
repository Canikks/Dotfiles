{osConfig, ...}: {
  programs.surge = {
    enable = true;
    headless = {
      enable = true;
      # tokenFile = "${osConfig.sops.secrets.surge_token.path}";
    };
  };
}
