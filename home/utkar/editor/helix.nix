{config, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter = {command = "alejandra";};
        }
      ];
    };
    settings = {
      # theme = "base16_transparent";
      editor = {
        line-number = "relative";
        completion-replace = true;
        lsp.display-messages = true;
        whitespace.render = "all";
        color-modes = true;
        clipboard-provider = "wayland";
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
    };
  };
}
