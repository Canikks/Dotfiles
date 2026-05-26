{ pkgs, ... }: {
  home.stateVersion = "25.05";
  home.homeDirectory = "/home/utkar";
  home.username = "utkar";
  home.shell.enableFishIntegration = true;
  home.preferXdgDirectories = true;
  home.shell.enableZshIntegration = true;

  # Window Manager
  wayland.windowManager.mango.enable = false;

  # XDG Configuration
  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.setSessionVariables = true;
    terminal-exec.enable = true;
    portal.xdgOpenUsePortal = true;
    autostart.enable = true;
    configFile = {
      "xdg-desktop-portal-termfilechooser/config" = {
        force = true;
        executable = true;
        text = ''
          [filechooser]
          cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
          default_dir=$HOME/downloads
          create_help_file=1
          env=TERMCMD='kitty --title filechooser'
          env=PATH="$PATH:/run/current-system/sw/bin"
          open_mode=suggested
          save_mode=last
        '';
      };
    };
  };
}