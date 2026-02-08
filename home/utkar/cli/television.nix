{...}: {
  programs.television = {
    enable = true;
    enableFishIntegration = true;
  };
  imports = [
    ./channels/files.nix
    ./channels/fish-history.nix
    ./channels/man-pages.nix
    # ./channels/nix.nix
    ./channels/procs.nix
    ./channels/text.nix
    ./channels/downloads.nix
  ];
}
