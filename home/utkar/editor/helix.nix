{config, ...}: {
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
        {
          name = "toml";
          language-servers = ["taplo"];
          formatter = {command = "taplo format";};
        }
      ];
      language-server.nixd = {
        command = "nixd";
        config.nixd = {
          nixpkgs = {
            expr = "import (builtins.getFlake \"/home/utkar/Dotfiles\").inputs.nixpkgs { }";
          };
          options = {
            # Enable Home Manager options completion
            home-manager = {
              # info: Adjust the path and configuration name below
              expr = "(builtins.getFlake \"/home/utkar/Dotfiles#utkar\").nixosConfigurations.utkar.options.home-manager.users.type.getSubOptions []";
            };
            # (Optional) Enable NixOS options completion
            nixos = {
              expr = "(builtins.getFlake \"/home/utkar/Dotfiles#utkar\").nixosConfigurations.utkar.options";
            };
          };
        };
      };
    };
    settings = {
      theme = "base16_transparent";
      editor = {
        line-number = "relative";
        bufferline = "always";
        completion-replace = true;
        lsp.display-messages = true;
        whitespace.render = "all";
        color-modes = true;
        clipboard-provider = "wayland";
        end-of-line-diagnostics = "hint";
        soft-wrap = {
          enable = true;
        };
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
    };
  };
}
