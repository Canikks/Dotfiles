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
    git
    sops
    age
    ssh-to-age
    treefmt
    nixd
    alejandra
  ];

  cachix = {
    enable = true;
    pull = ["nix-community" "nixos" "niri" "helix" "devenv"];
  };

  git-hooks.hooks = {
    treefmt.enable = true;
    deadnix.enable = false;
    shellcheck.enable = true;
    shellcheck.args = ["-e" "SC2034" "-e" "SC2148"];
  };

  scripts.rebuild-sys.exec = "nh os switch ~/dotfiles/ --cores 2 -j 2";
  scripts.update-flake.exec = "nix flake update";
  scripts.check-flake.exec = "nix flake check --impure";

  enterShell = ''
    echo $GREETING
    echo "Run 'rebuild-sys' to apply system changes."
  '';
}
