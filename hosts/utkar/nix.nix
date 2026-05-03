{
  inputs,
  lib,
  config,
  ...
}: {
  nix = {
    registry = lib.mapAttrs (_: flake: {inherit flake;}) inputs;
    nixPath = lib.mapAttrsToList (n: v: "${n}=${v}") inputs;
    channel.enable = false;
    nrBuildUsers = 0;
    daemonCPUSchedPolicy = "other";
    daemonIOSchedClass = "best-effort";

    settings = {
      # --- General & Performance ---
      max-jobs = "auto";
      cores = 4;
      compress-build-log = true;
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      builders-use-substitutes = true;
      keep-outputs = true;
      keep-derivations = true;

      # --- Experimental Features ---
      extra-experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
        "cgroups"
      ];
      use-cgroups = true;
      auto-allocate-uids = true;

      # --- Security & Tokens ---
      access-tokens = [
        "github.com=${builtins.readFile config.sops.secrets.github_token.path}"
      ];
      trusted-users = [
        "root"
        "utkar"
      ];
      extra-sandbox-paths = ["/dev" "/proc"];

      # --- Binary Caches (Substituters) ---
      substituters = [
        "https://attic.xuyh0120.win/lantian"
      ];
      trusted-substituters = [
        "https://hydra.nixos.org/"
      ];
      trusted-public-keys = [
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
      extra-substituters = [
        "https://cache.nixos.org"
        "https://watersucks.cachix.org"
        "https://yazi.cachix.org"
        "https://helix.cachix.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://wezterm.cachix.org"
        "https://ghostty.cachix.org"
        "https://nvf.cachix.org"
        "https://jjui.cachix.org"
        "https://hyprland.cachix.org"
        "https://cachix.cachix.org"
        "https://noctalia.cachix.org"
        "https://attic.xuyh0120.win/lantian"
        "https://cache.garnix.io"
        "https://millennium.cachix.org"
      ];
      extra-trusted-public-keys = [
        "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
        "jjui.cachix.org-1:G3rK4ezMNPMSHIuuDZgliF7Q/n9vZ3RNqmnt49UYhIg="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "millennium.cachix.org-1:oA14n26+32iES+5wBwfPAGR0y4ixRSG4rLMHzFxDwqc="
      ];
    };
  };
}
