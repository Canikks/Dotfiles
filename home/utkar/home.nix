{inputs, ...}: {
  imports = [
    # INPUT MODULES
    inputs.nix-index-database.homeModules.nix-index
    inputs.dankMaterialShell.homeModules.dank-material-shell
    inputs.dankMaterialShell.homeModules.niri
    inputs.mango.hmModules.mango
    inputs.dsearch.homeModules.default
    inputs.nvf.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    inputs.dms-plugin-registry.modules.default
    # SHELL CONFIG
    # ./shell/zsh.nix
    ./shell/fish.nix
    ./shell/prompt/starship.nix

    # TERMINAL CONFIG
    ./terminal/ghostty.nix
    # ./terminal/kitty.nix
    # ./terminal/rio.nix
    # ./terminal/wezterm.nix

    # EDITOR CONFIG
    ./editor/helix.nix
    ./editor/zeditor.nix
    # ./editor/nvf-nvim.nix

    # APPS
    ./apps/keepassxc.nix
    ./apps/vesktop.nix

    # FILE MANAGER CONFIG
    ./file-manager/yazi.nix

    # CLI TOOLS
    ./cli/aria2.nix
    ./cli/dsearch.nix
    ./cli/delta.nix
    ./cli/pay-respects.nix
    ./cli/fzf.nix
    ./cli/eza.nix
    ./cli/dank-material-shell.nix
    ./cli/television.nix
    ./cli/nix-search-tv.nix
    ./cli/nix-your-shell.nix
    ./cli/home-manager.nix
    ./cli/nix-index.nix
    ./cli/tealdeer.nix
    ./cli/zoxide.nix
    ./cli/lazygit.nix
    ./cli/git.nix
    # ./cli/navi.nix
    ./cli/bat.nix
    ./cli/opencode.nix

    # GAMING
    ./gaming/lutris.nix

    # MULTIPLEXER
    ./multiplexer/zellij.nix

    # AUDIO
    ./audio/easyeffects.nix
  ];

  home.stateVersion = "25.05";
  home.shell.enableFishIntegration = true;
  home.preferXdgDirectories = true;

  # sops = {
  #   defaultSopsFile = ../../secrets/secrets.yaml; # Adjust path relative to this file
  #   defaultSopsFormat = "yaml";
  #
  #   age.keyFile = "/home/utkar/.config/sops/age/keys.txt";
  #
  #   # This enables the secret
  #   secrets.openrouter_api_key = {
  #     # %r gets replaced by /run/user/<UID>
  #     path = "%r/secrets/openrouter_api_key";
  #   };
  # };

  # Nixpkgs Configuration
  nixpkgs.config.allowUnfree = true;

  # Window Manager
  wayland.windowManager.mango.enable = true;

  # XDG Configuration
  xdg = {
    userDirs.enable = true;
    terminal-exec.enable = true;
    portal.xdgOpenUsePortal = true;
    enable = true;
    autostart.enable = true;
  };
}
