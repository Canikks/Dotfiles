{
  # pkgs,
  # inputs,
  ...
}: {
  programs.television = {
    enable = true;
    enableFishIntegration = true;
    # package = inputs.television.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  imports = [
    ./channels/files.nix
    ./channels/fish-history.nix
    ./channels/man-pages.nix
    ./channels/procs.nix
    ./channels/text.nix
    ./channels/downloads.nix
  ];
}
