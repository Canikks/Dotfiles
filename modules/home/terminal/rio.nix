{
  pkgs,
  inputs,
  ...
}: {
  programs.rio = {
    enable = true;
    # package = inputs.rio.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # settings = {
    #   confirm-before-quit = false;
    #   window = {
    #     opacity = 0.8;
    #     colorspace = "srgb";
    #   };
    #   renderer = {
    #     backend = "automatic";
    #     performance = "high";
    #     level = 1;
    #   };
    #   editor = {
    #     program = "hx";
    #   };
    # };
  };
}
