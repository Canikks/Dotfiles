{
  config,
  pkgs,
  ...
}: {
  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = true;
  };
}
