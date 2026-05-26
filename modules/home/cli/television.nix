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
    ./channels
  ];
}
