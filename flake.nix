{
  description = "My NixOS system configuration flake";

  inputs = {
    # Core inputs
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
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    # Helpers & Utils
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
    ghostty.inputs.home-manager.follows = "home-manager";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
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
    zen-test.inputs.home-manager.follows = "home-manager";
  };

  # Force all inputs to follow the main nixpkgs to save space/versions
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
