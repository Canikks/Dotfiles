{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      theme = "dank-theme";
      editor = {
        line-number = "relative";
        bufferline = "always";
        completion-replace = true;
        lsp.display-progress-messages = true;
        whitespace.render = "all";
        color-modes = true;
        clipboard-provider = "wayland";
        end-of-line-diagnostics = "hint";
        soft-wrap = {
          enable = true;
        };
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
    };
  };
  imports = [
    ./helix-lang.nix
  ];
}
