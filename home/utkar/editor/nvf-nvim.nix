{pkgs, ...}: {
  programs.nvf = {
    enable = true;
    # defaultEditor = true;
    settings = {
      vim = {
        enableLuaLoader = true;
        syntaxHighlighting = true;
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        # keymaps = [
        #   {
        #     key = "<leader>-";
        #     mode = "n";
        #     silent = true;
        #     action = "<CMD>Oil<CR>";
        #   }
        # ];

        startPlugins = [pkgs.vimPlugins.multicursor-nvim];

        # lazy.plugins = {
        #   "multicursor.nvim" = {
        #     package = pkgs.vimPlugins.multicursor-nvim;
        #     enabled = true;
        #     keys = [
        #       {
        #         mode = ["n" "x"];
        #         key = "<up>";
        #         action = "function() require('multicursor-nvim').lineAddCursor(-1) end";
        #         lua = true;
        #       }
        #       {
        #         mode = ["n" "x"];
        #         key = "<down>";
        #         action = "function() require('multicursor-nvim').lineAddCursor(1) end";
        #         lua = true;
        #       }
        #       {
        #         mode = ["n" "x"];
        #         key = "<leader><up>";
        #         action = "function() require('multicursor-nvim').lineAddCursor(-1) end";
        #         lua = true;
        #       }
        #       {
        #         mode = ["n" "x"];
        #         key = "<leader><down>";
        #         action = "function() require('multicursor-nvim').lineAddCursor(1) end";
        #         lua = true;
        #       }
        #       {
        #         mode = ["n" "x"];
        #         key = "<leader>n";
        #         action = "function() require('multicursor-nvim').lineAddCursor(1) end";
        #         lua = true;
        #       }
        #       {
        #         mode = ["n" "x"];
        #         key = "<leader>s";
        #         action = "function() require('multicursor-nvim').lineAddCursor(1) end";
        #         lua = true;
        #       }
        #       {
        #         mode = ["n" "x"];
        #         key = "<leader>N";
        #         action = "function() require('multicursor-nvim').lineAddCursor(-1) end";
        #         lua = true;
        #       }
        #       {
        #         mode = ["n" "x"];
        #         key = "<leader>S";
        #         action = "function() require('multicursor-nvim').lineAddCursor(-1) end";
        #         lua = true;
        #       }
        #       {
        #         mode = ["n" "x"];
        #         key = "<c-q>";
        #         action = "require('multicursor-nvim').toggleCursor";
        #         lua = true;
        #       }
        #     ];
        #   };
        # };

        extraLuaFiles = [
          ./nixd.lua
        ];

        options = {
          autoindent = false;
          shiftwidth = 2;
          tabstop = 2;
          softtabstop = 2;
          wrap = true;
        };

        spellcheck = {
          enable = true;
          programmingWordlist.enable = false;
        };

        lsp = {
          # This must be enabled for the language modules to hook into
          # the LSP API.
          enable = true;
          null-ls.enable = true;
          formatOnSave = false;
          lspkind.enable = true;
          lightbulb.enable = true;
          lspsaga.enable = true;
          trouble.enable = true;
          lspSignature.enable = false; # conflicts with blink in maximal
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        # This section does not include a comprehensive list of available language modules.
        # To list all available language module options, please visit the nvf manual.
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          # Languages that will be supported in default and maximal configurations.
          nix = {
            enable = true;
            format.enable = true;
            lsp.servers = ["nixd"];
            extraDiagnostics = {
              enable = true;
              types = ["statix" "deadnix"];
            };
          };
          markdown.enable = true;

          # Languages that are enabled in the maximal configuration.
          bash.enable = true;
          clang.enable = false;
          css.enable = true;
          html.enable = true;
          sql.enable = false;
          java.enable = true;
          kotlin.enable = false;
          ts.enable = true;
          go.enable = true;
          lua.enable = true;
          zig.enable = false;
          python.enable = true;
          typst.enable = true;
          rust = {
            enable = true;
            extensions.crates-nvim.enable = true;
          };

          # Language modules that are not as common.
          assembly.enable = false;
          astro.enable = false;
          nu.enable = false;
          csharp.enable = false;
          julia.enable = false;
          vala.enable = false;
          scala.enable = false;
          r.enable = false;
          gleam.enable = false;
          dart.enable = false;
          ocaml.enable = false;
          elixir.enable = false;
          haskell.enable = false;
          ruby.enable = false;
          fsharp.enable = false;

          tailwind.enable = false;
          svelte.enable = false;

          # Nim LSP is broken on Darwin and therefore
          # should be disabled by default. Users may still enable
          # `vim.languages.vim` to enable it, this does not restrict
          # that.
          # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
          nim.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
          indent-blankline.setupOpts.indent.smart_indent_cap = true;

          # Fun
          cellular-automaton.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "base16";
          };
        };

        theme = {
          enable = true;
          name = "tokyonight";
          style = "storm";
          transparent = true;
        };

        autopairs.nvim-autopairs.enable = true;

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamed,unnamedplus";
        };

        # nvf provides various autocomplete options. The tried and tested nvim-cmp
        # is enabled in default package, because it does not trigger a build. We
        # enable blink-cmp in maximal because it needs to build its rust fuzzy
        # matcher library.
        autocomplete = {
          nvim-cmp.enable = false;
          blink-cmp.enable = true;
        };

        snippets.luasnip.enable = true;

        # filetree = {
        #   neo-tree = {
        #     enable = true;
        #   };
        # };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
          neogit.enable = true;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false; # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          yazi-nvim.enable = true;
          yazi-nvim.setupOpts.open_for_directories = true;
          oil-nvim = {
            enable = true;
            gitStatus = {
              enable = true;
            };
          };
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = true;
          yanky-nvim.setupOpts.ring.storage = "sqlite";
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = true;
          multicursors.enable = true;
          smart-splits.enable = true;
          undotree.enable = true;
          nvim-biscuits.enable = false;

          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = true;
          };
          images = {
            image-nvim.enable = false;
            img-clip.enable = true;
          };
        };

        notes = {
          obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = false;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = true; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = [
                "90"
                "130"
              ];
            };
          };
          fastaction.enable = true;
        };

        session = {
          nvim-session-manager.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };
      };
    };
  };
}
