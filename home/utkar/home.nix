{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.mango.hmModules.mango
    inputs.dsearch.homeModules.default
    ./shell/zsh.nix
    ./terminal/ghostty.nix
    ./editor/helix.nix
    ./file-manager/yazi.nix
    ./home-packages.nix
    ./shell/prompt/starship.nix
  ];
  home.stateVersion = "25.05";
  home.shell.enableZshIntegration = true;
  home.shell.enableBashIntegration = true;
  nixpkgs.config = {
    allowUnfree = true;
  };

  wayland.windowManager.mango = {
    enable = true;
  };

  programs.dsearch = {
    enable = true;
    # config = ''
    #   [[index_paths]]
    #   path = "/home/utkar"
    #   max_depth = 0
    #   exclude_hidden = false
    # '';
  };

  programs.dankMaterialShell = {
    enable = true;
    default.settings = {
      theme = "dark";
      dynamicTheming = true;
    };
    niri = {
      enableSpawn = true;
      enableKeybinds = true;
    };
    enableSystemSound = true;
    enableClipboard = true;
    enableSystemMonitoring = true;
    enableBrightnessControl = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableColorPicker = true;
    quickshell.package = inputs.quickshell.packages.x86_64-linux.default;
  };
  programs.nix-search-tv.enableTelevisionIntegration = true;
  programs.home-manager.enable = true;
  xdg.autostart = {
    enable = true;
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
}
