{inputs, ...}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dank-material-shell
    inputs.dankMaterialShell.homeModules.niri
    inputs.mango.hmModules.mango
    inputs.dsearch.homeModules.default
    inputs.nvf.homeManagerModules.default
    ./shell/zsh.nix
    ./shell/fish.nix
    ./terminal/ghostty.nix
    # ./terminal/kitty.nix
    # ./terminal/rio.nix
    ./editor/helix.nix
    ./editor/zeditor.nix
    ./file-manager/yazi.nix
    ./shell/prompt/starship.nix
    # ./editor/nvf-nvim.nix
    ./cli/aria2.nix
    ./gaming/lutris.nix
    ./multiplexer/zellij.nix
    ./audio/easyeffects.nix
  ];
  home.stateVersion = "25.05";
  home.shell.enableShellIntegration = true;
  home.shell.enableZshIntegration = true;
  home.shell.enableBashIntegration = true;
  home.shell.enableFishIntegration = true;
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

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.pay-respects = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.dank-material-shell = {
    default.settings = {
      theme = "dark";
      dynamicTheming = true;
    };
  };
  programs.nix-search-tv = {
    enable = true;
    settings = {
      indexes = ["nixpkgs" "home-manager" "nixos" "nur"];
    };
    enableTelevisionIntegration = true;
  };

  programs.nix-your-shell = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    nix-output-monitor.enable = true;
  };

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
    enableFishIntegration = true;
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
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
