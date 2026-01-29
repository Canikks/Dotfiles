{...}: {
  programs.helix.languages = {
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
            import (builtins.getFlake "/home/utkar/dotfiles").inputs.nixpkgs { }
          '';
        };

        options = {
          nixos = {
            expr = ''
              (builtins.getFlake "/home/utkar/dotfiles").nixosConfigurations.utkar.options
            '';
          };

          home-manager = {
            expr = ''
              (builtins.getFlake "/home/utkar/dotfiles").nixosConfigurations.utkar.options.home-manager.users.type.getSubOptions []
            '';
          };
        };
      };
    };
  };
}
