{
  # pkgs,
  # inputs,
  ...
}: {
  programs.television = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = false;
    # package = inputs.television.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  imports = [
    ./channels/files.nix
    ./channels/fish-history.nix
    ./channels/man-pages.nix
    ./channels/procs.nix
    ./channels/text.nix
    ./channels/downloads.nix
    ./channels/podman-images.nix
    ./channels/podman-networks.nix
    ./channels/podman-containers.nix
    ./channels/tldr.nix
    ./channels/podman-volumes.nix
    ./channels/zoxide.nix
    ./channels/systemd-units.nix
  ];
}
