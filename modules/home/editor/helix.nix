{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.default;
    extraPackages = with pkgs; [
      marksman
      hyprls
      taplo
      markdown-oxide
      rumdl
      nixd
    ];
    settings = {
      theme = "noctalia";
      editor = {
        line-number = "relative";
        bufferline = "always";
        completion-replace = false;
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
