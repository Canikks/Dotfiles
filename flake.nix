{
  description = "My NixOS system configuration flake";

  inputs = {
    # Nixos related inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-utils.url = "github:numtide/flake-utils";
    nixd.url = "github:nix-community/nixd";
    sops-nix.url = "github:Mic92/sops-nix";
    nixos-cli.url = "github:nix-community/nixos-cli";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    nyx-loner.url = "github:lonerOrz/nyx-loner";

    # Compositors and desktop shells
    hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";
    dank-material-shell.url = "github:AvengeMedia/DankMaterialShell";
    dms-plugin-registry.url = "github:AvengeMedia/dms-plugin-registry";
    noctalia.url = "github:noctalia-dev/noctalia-shell";

    # Helpers & Utils
    treefmt-nix.url = "github:numtide/treefmt-nix";
    mango.url = "github:DreamMaoMao/mangowc";
    nvf.url = "github:notashelf/nvf";
    helix.url = "github:helix-editor/helix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-output-monitor.url = "github:maralorn/nix-output-monitor";
    nix-your-shell.url = "github:MercuryTechnologies/nix-your-shell";
    quickshell.url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    dgop.url = "github:AvengeMedia/dgop";
    dsearch.url = "github:AvengeMedia/danksearch";
    rio.url = "github:raphamorim/rio/main";
    ghostty.url = "github:ghostty-org/ghostty";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nur.url = "github:nix-community/NUR";
    nh.url = "github:nix-community/nh";
    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
    alejandra.url = "github:kamadorueda/alejandra";
    yazi.url = "github:sxyazi/yazi";
    stylix.url = "github:nix-community/stylix";
    devenv.url = "github:cachix/devenv";
    pay-respects.url = "github:iffse/pay-respects";
    jjui.url = "github:idursun/jjui";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    television.url = "github:alexpasmantier/television";
    niri-autoselect-portal.url = "git+https://codeberg.org/debugloop/niri-autoselect-portal.git";
    optnix.url = "github:water-sucks/optnix";
    base46-src = {
      url = "github:AvengeMedia/base46";
      flake = false;
    };
    sddm-noctalia = {
      url = "github:mahaveergurjar/sddm/noctalia";
      flake = false;
    };
    hermes-agent.url = "github:NousResearch/hermes-agent/a91a57fa5a13d516c38b07a141a9ce8a3daabeb0";
    millennium.url = "github:SteamClientHomebrew/Millennium/11bebe4e5d2dea6246721241dc31c70d57d05129?dir=packages/nix";
    # millennium.url = "git+file:///home/utkar/Millennium/packages/nix/flake.nix";
    jj-starship.url = "github:dmmulroy/jj-starship";
    multios-usb.url = "github:Mexit/MultiOS-USB";
    quickemu.url = "github:quickemu-project/quickemu";
    surge.url = "github:SurgeDM/Surge/eebbc055baccff30de013e28d7de3ec4927a5ce6";
    yazelix-hm.url = "github:luccahuguet/yazelix";

    # Setting inputs to follow my shit
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland.inputs.nixpkgs.follows = "nixpkgs";
    # niri.inputs.nixpkgs.follows = "nixpkgs";
    # nirinit.inputs.nixpkgs.follows = "nixpkgs";
    dank-material-shell.inputs.nixpkgs.follows = "nixpkgs";
    dms-plugin-registry.inputs.nixpkgs.follows = "nixpkgs";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    mango.inputs.nixpkgs.follows = "nixpkgs";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    # helix.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-output-monitor.inputs.nixpkgs.follows = "nixpkgs";
    nix-your-shell.inputs.nixpkgs.follows = "nixpkgs";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
    dgop.inputs.nixpkgs.follows = "nixpkgs";
    dsearch.inputs.nixpkgs.follows = "nixpkgs";
    rio.inputs.nixpkgs.follows = "nixpkgs";
    ghostty.inputs.nixpkgs.follows = "nixpkgs";
    ghostty.inputs.home-manager.follows = "home-manager";
    wezterm.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    nh.inputs.nixpkgs.follows = "nixpkgs";
    nixos-cli.inputs.nixpkgs.follows = "nixpkgs";
    nix-search-tv.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    yazi.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    pay-respects.inputs.nixpkgs.follows = "nixpkgs";
    jjui.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
    television.inputs.nixpkgs.follows = "nixpkgs";
    # millennium.inputs.nixpkgs.follows = "nixpkgs";
    surge.inputs.nixpkgs.follows = "nixpkgs";
    yazelix-hm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in {
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations.utkar = inputs.nixpkgs.lib.nixosSystem {
      system = "${system}";
      specialArgs = {inherit inputs;};
      modules = with inputs; [
        ./hosts/utkar/configuration.nix
        niri-autoselect-portal.nixosModules.default
        niri.nixosModules.niri
        hyprland.nixosModules.default
        dank-material-shell.nixosModules.greeter
        dank-material-shell.nixosModules.dank-material-shell
        home-manager.nixosModules.home-manager
        nur.modules.nixos.default
        nur.repos.iopq.modules.nixos.xraya
        nur.legacyPackages.x86_64-linux.repos.iopq.modules.xraya
        nix-index-database.nixosModules.nix-index
        # mango.nixosModules.mango
        nixos-hardware.nixosModules.common-cpu-intel
        nixos-hardware.nixosModules.common-gpu-intel
        nixos-hardware.nixosModules.common-pc-laptop-ssd
        sops-nix.nixosModules.sops
        nixos-cli.nixosModules.nixos-cli
        # nirinit.nixosModules.nirinit
        stylix.nixosModules.stylix
        dms-plugin-registry.modules.default
        hermes-agent.nixosModules.default
        optnix.nixosModules.optnix
        surge.nixosModules.default
        nyx-loner.nixosModules.default
        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.extraSpecialArgs = {inherit inputs self system;};
          home-manager.users.utkar = import ./home/utkar/home.nix;
          home-manager.startAsUserService = true;
          home-manager.verbose = true;
          home-manager.backupCommand = "${pkgs.trash-cli}/bin/trash";
          home-manager.overwriteBackup = true;
        }
      ];
    };
    devShells.${system}.default = inputs.devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [
        ./devenv.nix
      ];
    };
  };
}
