{pkgs, ...}: {
  # 1. Environment Variables
  env.GREETING = "🛠️  Welcome to your NixOS Dotfiles Manager";

  # 1. Enable the treefmt integration
  treefmt.enable = true;

  # 2. Fix the "failed to find config" error
  # This tells treefmt that the folder containing "flake.nix" is the root.
  treefmt.config.projectRootFile = "flake.nix";

  # 3. Enable your requested formatters
  treefmt.config.programs = {
    # Nix
    alejandra.enable = true;

    # Lua
    stylua.enable = true;

    # Shell / Bash
    shfmt.enable = true;
    # Optional: ensure it indents with 2 spaces (common preference)
    shfmt.indent_size = 2;

    # TOML
    taplo.enable = true;
  };

  env.SOPS_AGE_KEY_FILE = "/home/utkar/.config/sops/age/keys.txt";

  # 2. Packages available in the shell
  # These won't be installed globally, only when you cd into this folder
  packages = with pkgs; [
    git
    sops # For secret management
    age
    ssh-to-age
    treefmt # Unified formatter
    nixd # Nix Language Server (amazing for VS Code / Neovim)
    alejandra # or alejandra
  ];

  cachix = {
    enable = true;
    pull = ["nix-community"];
  };

  # 3. Pre-commit hooks (The "Better Management" part)
  # Automatically lint and format your nix files before you commit.
  git-hooks.hooks = {
    # Format Nix code
    treefmt.enable = true;
    # Check for dead code (optional)
    deadnix.enable = true;
    # Lint shell scripts if you have them
    shellcheck.enable = true;
    shellcheck.args = ["-e" "SC2034" "-e" "SC2148"];
  };

  # 4. Custom Scripts (Shortcuts)
  # Instead of typing long rebuild commands, define aliases here.
  scripts.rebuild-sys.exec = "nh os switch ~/dotfiles/ --cores 2 -j 2";
  scripts.update-flake.exec = "nix flake update";
  scripts.check-flake.exec = "nix flake check";

  # 5. Shell integration
  enterShell = ''
    echo $GREETING
    echo "Run 'rebuild-sys' to apply system changes."
  '';
}
