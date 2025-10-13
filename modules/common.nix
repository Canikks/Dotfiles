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
    };
    television = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      autosuggestions.strategy = ["history" "completion" "match_prev_cmd"];
      zsh-autoenv.enable = true;
      enableGlobalCompInit = true;
      # Zsh options
      histSize = 10000;
      setOptions = [
        "HIST_IGNORE_ALL_DUPS"
        "HIST_FIND_NO_DUPS"
        "HIST_IGNORE_SPACE"
      ];

      # Aliases
      shellAliases = {
        ls = "eza --color=always --icons=always";
        ll = "eza -l --color=always --icons=always";
        la = "eza -la --color=always --icons=always";
        gs = "git status -u";
        nfu = "sudo nixos-rebuild switch --impure --flake /etc/nixos#utkar";
      };

      # Plugins
      ohMyZsh.plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zsh-users/zsh-syntax-highlighting";}
        {name = "zsh-users/zsh-completions";}
        {name = "zsh-users/zsh-history-substring-search";}
        {name = "junegunn/fzf";}
        {name = "romkatv/powerlevel10k";}
      ];

      # Prompt
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    };
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
