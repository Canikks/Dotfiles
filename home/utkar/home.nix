{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.zen-browser.homeModules.twilight
    # inputs.nvf.homeManagerModules.default
  ];
  home.stateVersion = "25.05";
  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.yazi = {
    enable = true;
    # plugins = {
    #   yatline = pkgs.yaziPlugins.yatline;
    # };
  };
  programs.zen-browser = {
    enable = true;
    # extraPrefsFiles = [
    #   (builtins.fetchurl {
    #     url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
    #     sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
    #   })
    # ];
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
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      background-opacity = 0.90;
      background-blur-radius = 32;
      custom-shader = "/home/utkar/.config/ghostty/ghostty-shader-playground/public/shaders/cursor_smear.glsl";
      config-file = "/home/utkar/.config/ghostty/config-dankcolors";
      cursor-style = "block";
      unfocused-split-opacity = 0.7;
      unfocused-split-fill = "#44464f";
      gtk-titlebar = false;
      # gtk-toolbar-style = "flat";
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title,no-cursor";
    };
  };
  programs.fish.enable = true;
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter = {command = "alejandra";};
        }
      ];
    };
    settings = {
      theme = "base16_transparent";
      editor = {
        line-number = "relative";
        completion-replace = true;
        lsp.display-messages = true;
        whitespace.render = "all";
        color-modes = true;
        clipboard-provider = "wayland";
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
    };
  };
  programs.dankMaterialShell.enable = true;
}
