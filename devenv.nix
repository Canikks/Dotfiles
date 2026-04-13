{pkgs, ...}: {
  env.GREETING = "🛠️  Welcome to your NixOS Dotfiles Manager";

  treefmt.enable = true;

  treefmt.config.projectRootFile = "flake.nix";

  treefmt.config.programs = {
    alejandra.enable = true;

    stylua.enable = true;

    shfmt.enable = true;
    shfmt.indent_size = 2;

    taplo.enable = true;
  };

  env.SOPS_AGE_KEY_FILE = "/home/utkar/.config/sops/age/keys.txt";

  packages = with pkgs; [
    sops
    age
    ssh-to-age
    treefmt
    nixd
    alejandra
    deadnix
    lua-language-server
  ];

  cachix = {
    enable = true;
    pull = ["nix-community" "nixos" "devenv" "yazi" "jjui" "helix" "niri" "cachix"];
  };

  git-hooks.hooks = {
    treefmt.enable = true;
    deadnix.enable = true;
    deadnix.args = ["-l"];
    shellcheck.enable = true;
  };

  # scripts.update-flake.exec = "nix flake update";
  # scripts.check-flake.exec = "nix flake check --impure";

  enterShell = ''
    echo $GREETING
    echo "Run 'rebuild-flake' to apply system changes."
  '';
}
