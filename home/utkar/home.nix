{
  self,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # INPUT MODULES
    inputs.nix-index-database.homeModules.nix-index
    inputs.dank-material-shell.homeModules.dank-material-shell
    # inputs.dank-material-shell.homeModules.niri
    inputs.mango.hmModules.mango
    inputs.dsearch.homeModules.default
    inputs.nvf.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    inputs.dms-plugin-registry.modules.default
    inputs.zen-browser.homeModules.beta
    inputs.noctalia.homeModules.default
    inputs.stylix.homeModules.stylix
    inputs.optnix.homeModules.optnix
    inputs.yazelix-hm.homeManagerModules.default
    inputs.chaotic.homeManagerModules.default

    # SHELL CONFIG
    ./shell

    # TERMINAL CONFIG
    ./terminal

    # EDITOR CONFIG
    ./editor

    # APPS
    ./apps

    # FILE MANAGER CONFIG
    ./file-manager

    # CLI TOOLS
    ./cli

    # BROWSER
    ./browser

    # GAMING
    ./gaming

    # MULTIPLEXER
    ./multiplexer

    # AUDIO
    ./audio

    # DESKTOP-SHELL
    ./desktop-shell
  ];

  home.stateVersion = "25.05";
  home.homeDirectory = "/home/utkar";
  home.username = "utkar";
  home.shell.enableFishIntegration = true;
  home.preferXdgDirectories = true;
  home.shell.enableZshIntegration = true;

  nixpkgs.overlays = self.nixosConfigurations.utkar.config.nixpkgs.overlays;
  nixpkgs.config = self.nixosConfigurations.utkar.config.nixpkgs.config;

  # stylix.base16Scheme = "/home/utkar/.config/DankMaterialShell/base16.yaml";
  # stylix.targets.helix.enable = true;
  # stylix.targets.bat.enable = true;
  # stylix.targets.nvf.enable = true;
  # stylix.enable = true;
  # stylix.autoEnable = false;
  # stylix.polarity = "dark";

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
