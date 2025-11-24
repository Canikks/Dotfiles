{config, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter = {command = "alejandra";};
        }
        {
          name = "toml";
          language-servers = ["taplo"];
          formatter = {command = "taplo format";};
        }
      ];
    };
    settings = {
      theme = "base16_transparent";
      editor = {
        line-number = "relative";
        bufferline = "always";
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
