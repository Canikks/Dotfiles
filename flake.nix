{
  description = "My NixOS system configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-utils.url = "github:numtide/flake-utils";
    nixd.url = "github:nix-community/nixd";
    sops-nix.url = "github:Mic92/sops-nix";
    # Community tools & Desktops
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    dankMaterialShell.url = "github:AvengeMedia/DankMaterialShell";
    dankMaterialShell.inputs.nixpkgs.follows = "nixpkgs";
    # dankMaterialShell.inputs.dgop.follows = "dgop";

    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    # Helpers & Utils (Consolidated follows)
    treefmt-nix.url = "github:numtide/treefmt-nix";
    mango.url = "github:DreamMaoMao/mangowc";
    nvf.url = "github:notashelf/nvf";
    helix.url = "github:helix-editor/helix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-output-monitor.url = "github:maralorn/nix-output-monitor";
    nix-your-shell.url = "github:MercuryTechnologies/nix-your-shell";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    dgop.url = "github:AvengeMedia/dgop";
    dsearch.url = "github:AvengeMedia/danksearch";
    rio.url = "github:raphamorim/rio/main";
    ghostty.url = "github:ghostty-org/ghostty";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nur.url = "github:nix-community/NUR";
    nh.url = "github:nix-community/nh";
    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
    alejandra.url = "github:kamadorueda/alejandra";
    yazi.url = "github:sxyazi/yazi";
    stylix.url = "github:nix-community/stylix";
    devenv.url = "github:cachix/devenv";

    # Local
    zen-test.url = "path:/home/utkar/zen-browser-flake";

    # Force all above to follow the main nixpkgs to save space/versions
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    mango.inputs.nixpkgs.follows = "nixpkgs";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-output-monitor.inputs.nixpkgs.follows = "nixpkgs";
    nix-your-shell.inputs.nixpkgs.follows = "nixpkgs";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
    dgop.inputs.nixpkgs.follows = "nixpkgs";
    dsearch.inputs.nixpkgs.follows = "nixpkgs";
    rio.inputs.nixpkgs.follows = "nixpkgs";
    ghostty.inputs.nixpkgs.follows = "nixpkgs";
    ghostty.inputs.home-manager.follows = "home-manager";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    nh.inputs.nixpkgs.follows = "nixpkgs";
    nix-search-tv.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    yazi.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    zen-test.inputs.nixpkgs.follows = "nixpkgs";
    zen-test.inputs.home-manager.follows = "home-manager";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations.utkar = inputs.nixpkgs.lib.nixosSystem {
      system = "${system}";
      specialArgs = {inherit inputs;};
      modules = with inputs; [
        ./hosts/utkar/configuration.nix
        niri.nixosModules.niri
        dankMaterialShell.nixosModules.greeter
        dankMaterialShell.nixosModules.dank-material-shell
        noctalia.nixosModules.default
        home-manager.nixosModules.home-manager
        nur.modules.nixos.default
        nur.legacyPackages.x86_64-linux.repos.iopq.modules.xraya
        nix-index-database.nixosModules.nix-index
        mango.nixosModules.mango
        nixos-hardware.nixosModules.common-cpu-intel
        nixos-hardware.nixosModules.common-gpu-intel
        nixos-hardware.nixosModules.common-pc-laptop-ssd
        sops-nix.nixosModules.sops
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.utkar = import ./home/utkar/home.nix;
        }
      ];
    };
    devShells.${system}.default = inputs.devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [
        # Import the actual logic from a separate file to keep flake.nix clean
        ./devenv.nix
      ];
    };
  };
}
