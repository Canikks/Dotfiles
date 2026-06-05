{
  pkgs,
  inputs,
  ...
}: {
  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings = {
      vim = {
        lazy.plugins = {
          base46 = {
            package = pkgs.vimUtils.buildVimPlugin {
              pname = "base46";
              version = "unstable";

              src = inputs.base46-src;
              doCheck = false;
            };
            lazy = false;
            priority = 1000;
            after = ''
              vim.g.base46_theme = "dms"
              vim.cmd.colorscheme("dms")

              -- Optional integrations config
              vim.g.base46_transparency = true
            '';
          };
          kitty-scrollback = {
            package = pkgs.vimUtils.buildVimPlugin {
              pname = "kitty-scrollback";
              version = "^9.2.0";
              src = inputs.kitty-scrollback;
              doCheck = false;
            };
            enabled = true;
            lazy = true;
            cmd = [
              "KittyScrollbackGenerateKittens"
              "KittyScrollbackCheckHealth"
              "KittyScrollbackGenerateCommandLineEditing"
            ];
            event = "User KittyScrollbackLaunch";
          };
        };
        keymaps = [
          {
            key = "_";
            mode = "n";
            action = "<CMD>Oil<CR>";
          }
        ];
        enableLuaLoader = true;
        syntaxHighlighting = true;
        viAlias = true;
        vimAlias = true;
        extraLuaFiles = [
          ./nixd.lua
        ];
        additionalRuntimePaths = ["/home/utkar/.config/nvim"];
        options = {
          autoindent = false;
          shiftwidth = 2;
          tabstop = 2;
          softtabstop = 2;
          wrap = true;
        };
        spellcheck.enable = true;
        lsp = {
          enable = true;
          null-ls.enable = true;
          formatOnSave = true;
          lspkind.enable = true;
          lightbulb.enable = false;
          lspsaga.enable = true;
          otter-nvim.enable = false;
          nvim-docs-view.enable = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix = {
            enable = true;
            format.enable = true;
            lsp.servers = ["nixd"];
            extraDiagnostics = {
              enable = true;
              types = ["statix" "deadnix"];
            };
          };
          yaml.enable = true;
          haskell.enable = false;
          markdown.enable = true;
          bash.enable = true;
          css.enable = false;
          html.enable = true;
          typescript.enable = false;
          go.enable = false;
          lua.enable = true;
          python.enable = true;
          rust.extensions.crates-nvim.enable = false;
        };
        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = false;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
          indent-blankline.setupOpts.indent.smart_indent_cap = true;
          cellular-automaton.enable = true;
        };
        statusline.lualine = {
          enable = true;
          # theme = "base16";
        };
        # theme = {
        #   enable = true;
        #   name = "tokyonight";
        #   style = "storm";
        #   transparent = true;
        # };
        autopairs.nvim-autopairs.enable = true;
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamed,unnamedplus";
        };
        autocomplete.blink-cmp.enable = true;
        # autocomplete.enableSharedCmpSources = true;
        # autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;
        tabline.nvimBufferline.enable = true;
        treesitter.context.enable = true;
        binds = {
          whichKey.enable = true;
          whichKey.setupOpts = {
            preset = "modern";
          };
          cheatsheet.enable = true;
        };
        telescope.enable = true;
        git = {
          enable = true;
          gitsigns.enable = true;
          neogit.enable = true;
        };
        # filetree.neo-tree.enable = true;
        dashboard.alpha.enable = true;
        notify.nvim-notify.enable = true;
        utility = {
          # yazi-nvim.enable = true;
          # yazi-nvim.setupOpts.open_for_directories = true;
          oil-nvim = {
            enable = true;
            gitStatus.enable = true;
            setupOpts.open_for_directories = true;
          };
          diffview-nvim.enable = true;
          nix-develop.enable = true;
          yanky-nvim.enable = true;
          yanky-nvim.setupOpts.ring.storage = "sqlite";
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = true;
          multicursors.enable = true;
          smart-splits.enable = true;
          undotree.enable = true;
          motion = {
            hop.enable = false;
            leap.enable = false;
            precognition.enable = false;
          };
          images.img-clip.enable = true;
        };
        terminal.toggleterm = {
          enable = true;
          setupOpts = {
            direction = "tab";
            enable_winbar = true;
          };
          lazygit.enable = false;
        };
        ui = {
          ui2.enable = false;
          noice.enable = true;
          modes-nvim.enable = true;
          illuminate.enable = false;
          breadcrumbs = {
            enable = false;
            navbuddy.enable = false;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };
        comments.comment-nvim.enable = true;
      };
    };
  };
}
