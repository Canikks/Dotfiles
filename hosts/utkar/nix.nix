{
  inputs,
  lib,
  ...
}: {
  nix = {
    registry = lib.mapAttrs (_: flake: {inherit flake;}) inputs;
    nixPath = lib.mapAttrsToList (n: v: "${n}=${v}") inputs;
    channel.enable = false;
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    settings = {
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
      extra-substituters = [
        "https://watersucks.cachix.org"
        "https://yazi.cachix.org"
        "https://helix.cachix.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
      ];
      extra-trusted-public-keys = [
        "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };
}
