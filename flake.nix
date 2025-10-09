{
  description = "My NixOS system configuration flake (modularized and maintainable)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvix.url = "github:niksingh710/nvix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    niri,
    dankMaterialShell,
    ghostty,
    zen-browser,
    nur,
    chaotic,
    nix-index-database,
    quickshell,
    nvix,
    nvf,
    ...
  }: {
    nixosConfigurations = {
      utkar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/utkar/configuration.nix
          ./packages.nix
          dankMaterialShell.nixosModules.greeter
          home-manager.nixosModules.home-manager
          chaotic.nixosModules.default
          nur.modules.nixos.default
          nur.legacyPackages.x86_64-linux.repos.iopq.modules.xraya
          nvf.nixosModules.default
          nix-index-database.nixosModules.nix-index
          (
            {pkgs, ...}: {
              environment.systemPackages = [
                quickshell.packages.x86_64-linux.default
                ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
                dankMaterialShell.packages.${pkgs.stdenv.hostPlatform.system}.default
              ];
            }
          )
          {
            programs.nvf = {
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

                  spellcheck = {
                    enable = true;
                    programmingWordlist.enable = false;
                  };

                  lsp = {
                    # This must be enabled for the language modules to hook into
                    # the LSP API.
                    enable = true;

                    formatOnSave = true;
                    lspkind.enable = false;
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
                    nix.enable = true;
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
          }
          {
            # programs.dankMaterialShell.greeter = {
            #   enable = true;
            #   compositor.name = "niri"; # or set to hyprland
            #   configHome = "/home/user"; # optionally copyies that users DMS settings (and wallpaper if set) to the greeters data directory as root before greeter starts
            # };
          }
          {programs.nix-index-database.comma.enable = true;}
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.utkar = import ./home/utkar/home.nix {
              inherit inputs;
            };
          }
        ];
      };
    };
  };
}
