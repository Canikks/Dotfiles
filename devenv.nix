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
    deadnix
  ];

  cachix = {
    enable = true;
    pull = ["nix-community" "nixos" "niri" "helix" "devenv"];
  };

  git-hooks.hooks = {
    treefmt.enable = true;
    deadnix.enable = true;
    deadnix.args = ["-l"];
    shellcheck.enable = true;
    # shellcheck.args = ["-e" "SC2034" "-e" "SC2148"];
  };

  # scripts.rebuild-flake.exec = "nh os switch ~/dotfiles --cores 2 -j 2 --ask --commit-lock-file";
  scripts.rebuild-flake.exec = "nixos apply";
  # scripts.build-flake.exec = "nh os build ~/dotfiles --cores 2 -j 2";
  scripts.build-flake.exec = "nixos apply --no-boot --no-activate --output ./result";
  # scripts.test-flake.exec = "nh os test ~/dotfiles --cores 2 -j 2";
  scripts.test-flake.exec = "nixos apply --no-boot";
  scripts.update-flake.exec = "nix flake update";
  scripts.check-flake.exec = "nix flake check --impure";

  enterShell = ''
    echo $GREETING
    echo "Run 'rebuild-sys' to apply system changes."
  '';
}
