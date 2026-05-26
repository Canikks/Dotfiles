{
  pkgs,
  inputs,
  ...
}: {
  programs.wezterm = {
    enable = false;
    package = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  xdg.configFile."wezterm/wezterm.lua" = {
    source = ./wezterm.lua;
  };
}
