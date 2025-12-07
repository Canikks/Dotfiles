{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.mango.hmModules.mango
    inputs.dsearch.homeModules.default
    inputs.nvf.homeManagerModules.default
    ./shell/zsh.nix
    ./terminal/ghostty.nix
    # ./terminal/kitty.nix
    ./terminal/rio.nix
    ./editor/helix.nix
    ./file-manager/yazi.nix
    ./shell/prompt/starship.nix
    # ./editor/nvf-nvim.nix
    ./cli/aria2.nix
    ./gaming/lutris.nix
    # ./multiplexer/zellij.nix
    ./audio/easyeffects.nix
  ];
  home.stateVersion = "25.05";
  home.shell.enableZshIntegration = true;
  home.shell.enableBashIntegration = true;
  home.preferXdgDirectories = true;
  nixpkgs.config = {
    allowUnfree = true;
  };

  wayland.windowManager.mango = {
    enable = true;
  };

  programs.dsearch = {
    enable = true;
  };

  programs.dankMaterialShell = {
    enable = true;
    # systemd.enable = true;
    default.settings = {
      theme = "dark";
      dynamicTheming = true;
    };
    enableSystemSound = true;
    enableClipboard = true;
    enableSystemMonitoring = true;
    enableBrightnessControl = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableColorPicker = true;
    enableCalendarEvents = false;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  programs.nix-search-tv.enableTelevisionIntegration = true;
  programs.home-manager.enable = true;
  xdg.autostart = {
    enable = true;
  };

  xdg = {
    configFile."mango" = {
      source = ./mango;
      recursive = true;
    };
    configFile."television/cable/nix.toml" = {
      source = ./nix.toml;
    };
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.keepassxc = {
    enable = true;
    autostart = true;
  };
  programs.tealdeer = {
    settings = {
      updates = {
        auto_update = true;
      };
    };
  };
  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };
}
