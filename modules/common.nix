{
  config,
  pkgs,
  lib,
  ...
}: {
  # Common reusable configuration for all systems (useful if you ever add another host)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs = {
    nvf = {
      enable = true;
      settings = {
        vim = {
          syntaxHighlighting = true;
          viAlias = true;
          vimAlias = true;
          debugMode = {
            enable = false;
            level = 16;
            logFile = "/tmp/nvim.log";
          };

          options = {
            autoindent = true;
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

            formatOnSave = true;
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
              lsp.enable = true;
              lsp.server = "nil";
              treesitter.enable = false;
            };
            markdown.enable = true;

            # Languages that are enabled in the maximal configuration.
            bash.enable = true;
            clang.enable = true;
            css.enable = true;
            html.enable = true;
            sql.enable = true;
            java.enable = true;
            kotlin.enable = true;
            ts.enable = true;
            go.enable = true;
            lua.enable = true;
            zig.enable = true;
            python.enable = true;
            typst.enable = true;
            rust = {
              enable = true;
              crates.enable = true;
            };

            # Language modules that are not as common.
            assembly.enable = true;
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
            ruby.enable = true;
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

          filetree = {
            neo-tree = {
              enable = true;
            };
          };

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
            codewindow.enable = true; # lighter, faster, and uses lua for configuration
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
            ccc.enable = false;
            vim-wakatime.enable = false;
            diffview-nvim.enable = true;
            yanky-nvim.enable = false;
            icon-picker.enable = true;
            surround.enable = true;
            leetcode-nvim.enable = true;
            multicursors.enable = true;
            smart-splits.enable = true;
            undotree.enable = true;
            nvim-biscuits.enable = true;

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
            mind-nvim.enable = true;
            todo-comments.enable = true;
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

          assistant = {
            chatgpt.enable = false;
            copilot = {
              enable = false;
              cmp.enable = false;
            };
            codecompanion-nvim.enable = false;
            avante-nvim.enable = false;
          };

          session = {
            nvim-session-manager.enable = false;
          };

          gestures = {
            gesture-nvim.enable = false;
          };

          comments = {
            comment-nvim.enable = true;
          };

          presence = {
            neocord.enable = false;
          };
        };
      };
    };
    nh = {
      enable = true;
      clean = {
        enable = true;
      };
      flake = "home/utkar/dotfiles#utkar";
    };
    bat = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      lfs = {
        enable = true;
      };
    };

    niri = {
      enable = true;
      # cache.enable = true;
      package = pkgs.niri-unstable;
    };
    television = {
      enable = true;
      enableZshIntegration = true;
    };
      zsh = {
        enable = true;
      };
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   enableBashCompletion = true;
    #   syntaxHighlighting.enable = true;
    #   autosuggestions.enable = true;
    #   autosuggestions.strategy = ["history" "completion" "match_prev_cmd"];
    #   zsh-autoenv.enable = true;
    #   enableGlobalCompInit = true;
    #   # Zsh options
    #   histSize = 10000;
    #   setOptions = [
    #     "HIST_IGNORE_ALL_DUPS"
    #     "HIST_FIND_NO_DUPS"
    #     "HIST_IGNORE_SPACE"
    #   ];

    #   # Aliases
    #   shellAliases = {
    #     ls = "eza --color=always --icons=always";
    #     ll = "eza -l --color=always --icons=always";
    #     la = "eza -la --color=always --icons=always";
    #     gs = "git status -u";
    #     nfu = "sudo nixos-rebuild switch --impure --flake /etc/nixos#utkar";
    #   };

    #   # Plugins
    #   ohMyZsh.plugins = [
    #     {name = "zsh-users/zsh-autosuggestions";}
    #     {name = "zsh-users/zsh-syntax-highlighting";}
    #     {name = "zsh-users/zsh-completions";}
    #     {name = "zsh-users/zsh-history-substring-search";}
    #     {name = "junegunn/fzf";}
    #     {name = "romkatv/powerlevel10k";}
    #   ];

    #   # Prompt
    #   promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    # };
    uwsm = {
      enable = true;
      waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };
    };
    steam = {
      enable = true;
      extest.enable = true;
    };
    gamescope = {
      enable = true;
    };
    gamemode = {
      enable = true;
    };
  };

  services.flatpak.enable = true;
  # services.udisks2.enable = true;

  # Optional example overlay usage
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     # Example overlay
  #     my-custom-htop = prev.htop.override { enableDelay = true; };
  #   })
  # ];
}
