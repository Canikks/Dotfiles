{lib, config, pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --color=always --icons=always";
      ll = "eza -l --color=always --icons=always";
      la = "eza -la --color=always --icons=always";
      gs = "git status -u";
      nix = "noglob nix";
      nom = "noglob nom";
      ze = "zellij";
      zserver = "zellij --layout=server";
    };
  };
} 
