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
    inputs.nirinit.homeModules.nirinit
    inputs.zen-browser.homeModules.twilight
    # SHELL CONFIG
    # ./shell/zsh.nix
    ./shell/fish.nix

    # TERMINAL CONFIG
    ./terminal/kitty.nix
    # ./terminal/wezterm.nix
    ./terminal/ghostty.nix
    # ./terminal/rio.nix

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
    ./cli/ripgrep-all.nix
    ./cli/fd.nix
    ./cli/dank-material-shell.nix
    ./cli/television.nix
    ./cli/nix-search-tv.nix
    ./cli/nix-your-shell.nix
    ./cli/home-manager.nix
    ./cli/nix-index.nix
    ./cli/tealdeer.nix
    ./cli/zoxide.nix
    ./cli/lazygit.nix
    ./cli/jjui.nix
    ./cli/git.nix
    ./cli/jujutsu.nix
    # ./cli/navi.nix
    ./cli/bat.nix
    ./cli/opencode.nix
    ./cli/hyfetch.nix
    ./cli/fastfetch.nix
    # ./cli/aichat.nix

    # BROWSER
    ./browser/zen-browser.nix

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
