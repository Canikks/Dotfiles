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
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    settings = {
      # access-tokens = [
      #   "github.com=${builtins.readFile config.sops.secrets.github_token.path}"
      # ];
      netrc-file = config.sops.secrets.netrc.path;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "utkar"
      ];
      use-xdg-base-directories = true;
      builders-use-substitutes = true;
      auto-optimise-store = true;

      keep-outputs = true;
      keep-derivations = true;

      max-jobs = 2;
      cores = 2;
      build-cores = 2;
      compress-build-log = true;

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
      ];
    };
  };
}
