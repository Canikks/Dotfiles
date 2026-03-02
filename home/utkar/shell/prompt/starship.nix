{...}: {
  programs.starship = {
    enable = true;
    # enableZshIntegration = true;
    # enableBashIntegration = true;
    # enableFishIntegration = true;
    enableTransience = true;
  };
  xdg.configFile."starship.toml".source = ./starship.toml;
}
