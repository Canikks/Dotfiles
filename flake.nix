{
  description = "My NixOS system configuration flake (modularized and maintainable)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvix.url = "github:niksingh710/nvix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-cli = {
      url = "github:AvengeMedia/danklinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
      inputs.dms-cli.follows = "dms-cli";
    };
    flake-utils.url = "github:numtide/flake-utils";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixd = {
      url = "github:nix-community/nixd";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    niri,
    dankMaterialShell,
    ghostty,
    zen-browser,
    nur,
    chaotic,
    nix-index-database,
    quickshell,
    nvix,
    nvf,
    nixd,
    ...
  }: {
    nixosConfigurations = {
      utkar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/utkar/configuration.nix
          ./packages.nix
          dankMaterialShell.nixosModules.greeter
          home-manager.nixosModules.home-manager
          chaotic.nixosModules.default
          nur.modules.nixos.default
          nur.legacyPackages.x86_64-linux.repos.iopq.modules.xraya
          nvf.nixosModules.default
          nix-index-database.nixosModules.nix-index
          (
            {pkgs, ...}: {
              nixpkgs.overlays = [niri.overlays.niri];
              environment.systemPackages = [
                ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
                pkgs.niri-unstable
                nixd.packages.${pkgs.stdenv.hostPlatform.system}.default
              ];
            }
          )
          {
            nixpkgs.overlays = [niri.overlays.niri];
          }
          {
            programs.dankMaterialShell.greeter = {
              enable = true;
              compositor.name = "niri"; # or set to hyprland
              configHome = "/home/utkar"; # optionally copyies that users DMS settings (and wallpaper if set) to the greeters data directory as root before greeter starts
            };
          }
          {programs.nix-index-database.comma.enable = true;}
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.utkar = import ./home/utkar/home.nix {
              inherit inputs;
            };
          }
        ];
      };
    };
  };
}
