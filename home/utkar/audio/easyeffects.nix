{
  config,
  pkgs,
  lib,
  ...
}: {
  services.easyeffects = {
    enable = true;
    preset = "GentleDynamics Feather Loudness";
  };
}
