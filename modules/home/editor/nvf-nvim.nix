{
  pkgs,
  inputs,
  ...
}: {
  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings = {
      vim.searchCase = "smart";
      vim.lazy.plugins = {
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
        # jj-nvim = {
        #   package = pkgs.vimUtils.buildVimPlugin {
        #     pname = "jj-nvim";
        #     version = "unstable";
        #
        #     src = inputs.jj-nvim;
        #   };
        #   lazy = false;
        # };
      };
      vim.keymaps = [
        {
          key = "_";
          mode = "n";
          action = "<CMD>Oil<CR>";
        }
        {
          key = "K";
          mode = "n";
          action = "<CMD>Lspsaga hover_doc<CR>";
        }
      ];
      vim.extraPackages = with pkgs; [
        fzf
        ripgrep
        nixd
      ];
      vim.debugger.nvim-dap = {
        enable = true;
      };
      vim.enableLuaLoader = true;
      vim.syntaxHighlighting = true;
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.extraLuaFiles = [
        ./nixd.lua
      ];
      vim.fzf-lua = {
        enable = true;
      };
      vim.formatter.conform-nvim.enable = true;
      vim.runner.run-nvim.enable = true;
      vim.additionalRuntimePaths = ["/home/utkar/.config/nvim"];
      vim.options = {
        autoindent = true;
        shiftwidth = 2;
        tabstop = 2;
        softtabstop = 2;
        wrap = true;
        guicursor = "n-v-i-c:block-Cursor";
      };
      vim.spellcheck.enable = true;
      vim.lsp = {
        enable = true;
        null-ls.enable = true;
        formatOnSave = true;
        lspkind.enable = true;
        lightbulb.enable = false;
        lspsaga.enable = true;
        otter-nvim.enable = true;
        nvim-docs-view.enable = true;
      };
      vim.languages = {
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
      vim.visuals = {
        blink-indent.enable = true;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = false;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
        indent-blankline.setupOpts.indent.smart_indent_cap = true;
        cellular-automaton.enable = true;
      };
      vim.statusline.lualine = {
        enable = true;
      };
      vim.autopairs.nvim-autopairs.enable = true;
      vim.clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamed,unnamedplus";
      };
      vim.autocomplete.blink-cmp.enable = true;
      vim.snippets.luasnip.enable = true;
      vim.snippets.luasnip.setupOpts.enable_autosnippets = true;
      vim.undoFile.enable = true;
      vim.tabline.nvimBufferline.enable = true;
      vim.treesitter = {
        grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
        enable = true;
        fold = false;
        context.enable = true;
        textobjects.enable = true;
      };
      vim.binds = {
        whichKey.enable = true;
        whichKey.setupOpts = {
          preset = "modern";
        };
        cheatsheet.enable = true;
      };
      vim.telescope.enable = true;
      vim.git = {
        enable = true;
        gitsigns.enable = true;
        neogit.enable = false;
      };
      vim.dashboard.alpha.enable = false;
      vim.notify.nvim-notify.enable = true;
      vim.utility = {
        # yazi-nvim.enable = true;
        # yazi-nvim.setupOpts.open_for_directories = true;
        oil-nvim = {
          enable = true;
          gitStatus.enable = true;
          setupOpts = {
            open_for_directories = true;
            columns = [
              "icon"
              "permissions"
              "size"
              "mtime"
            ];
            buf_options = {
              buflisted = true;
            };
            win_options = {
              spell = false;
              list = true;
            };
          };
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
        images.image-nvim.enable = true;
        images.image-nvim.setupOpts = {
          backend = "kitty";
        };
      };
      vim.terminal.toggleterm = {
        enable = true;
        mappings.open = "<M-t>";
        setupOpts = {
          direction = "float";
          enable_winbar = true;
        };
        lazygit.enable = false;
      };
      vim.notes.neorg = {
        enable = false;
        setupOpts = {
          load = {
            core.defaults = {};
          };
        };
        treesitter.enable = true;
      };
      vim.ui = {
        ui2.enable = true;
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
      vim.comments.comment-nvim.enable = true;
    };
  };
}
