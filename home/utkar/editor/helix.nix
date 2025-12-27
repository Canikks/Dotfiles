{...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
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
            expr = ''
              import (builtins.getFlake \"/home/utkar/dotfiles\").inputs.nixpkgs { }
            '';
          };

          options = {
            home-manager = {
              expr = ''
                (builtins.getFlake (builtins.toString ./.)).nixosConfigurations.utkar.options.home-manager.users.type.getSubOptions [])
              '';
            };

            nixos = {
              expr = ''
                (builtins.getFlake (builtins.toString ./.)).nixosConfigurations.utkar.options
              '';
            };
          };
        };
      };
    };
  };
}
