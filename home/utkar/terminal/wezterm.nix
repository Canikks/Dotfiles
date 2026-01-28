{
  pkgs,
  inputs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  xdg.configFile."wezterm/wezterm.lua" = {
    source = ./wezterm.lua;
  };
}
