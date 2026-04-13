{
  config,
  inputs,
  ...
}: {
  imports = [
    # INPUT MODULES
    inputs.nix-index-database.homeModules.nix-index
    inputs.dank-material-shell.homeModules.dank-material-shell
    # inputs.dank-material-shell.homeModules.niri
    inputs.mango.hmModules.mango
    inputs.dsearch.homeModules.default
    inputs.nvf.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    inputs.dms-plugin-registry.modules.default
    inputs.zen-browser.homeModules.beta
    inputs.noctalia.homeModules.default
    inputs.stylix.homeModules.stylix

    # SHELL CONFIG
    ./shell/zsh.nix
    ./shell/fish.nix

    # TERMINAL CONFIG
    ./terminal/kitty.nix
    # ./terminal/wezterm.nix
    ./terminal/ghostty.nix
    # ./terminal/rio.nix

    # EDITOR CONFIG
    ./editor/helix.nix
    ./editor/zeditor.nix
    ./editor/nvf-nvim.nix
    # ./editor/neovide.nix

    # APPS
    ./apps/keepassxc.nix
    ./apps/vesktop.nix
    ./apps/noctalia.nix

    # FILE MANAGER CONFIG
    ./file-manager/yazi.nix

    # CLI TOOLS
    # ./cli/aria2.nix
    ./cli/dsearch.nix
    ./cli/delta.nix
    ./cli/pay-respects.nix
    ./cli/fzf.nix
    # ./cli/eza.nix
    ./cli/lsd.nix
    ./cli/ripgrep-all.nix
    ./cli/ripgrep.nix
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
    ./cli/bat.nix
    ./cli/opencode.nix
    ./cli/hyfetch.nix
    ./cli/fastfetch.nix
    # ./cli/aichat.nix

    # BROWSER
    ./browser/zen-browser.nix
    # ./browser/floorp.nix

    # GAMING
    ./gaming/lutris.nix

    # MULTIPLEXER
    ./multiplexer/zellij.nix

    # AUDIO
    # ./audio/easyeffects.nix
  ];

  home.stateVersion = "25.05";
  home.homeDirectory = "/home/utkar";
  home.username = "utkar";
  home.shell.enableFishIntegration = true;
  home.preferXdgDirectories = true;
  home.shell.enableZshIntegration = true;

  # stylix.base16Scheme = "/home/utkar/.config/DankMaterialShell/base16.yaml";
  # stylix.targets.helix.enable = true;
  # stylix.targets.bat.enable = true;
  # stylix.targets.nvf.enable = true;
  # stylix.enable = true;
  # stylix.autoEnable = false;
  # stylix.polarity = "dark";

  # Window Manager
  wayland.windowManager.mango.enable = false;

  # XDG Configuration
  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.setSessionVariables = true;
    terminal-exec.enable = true;
    portal.xdgOpenUsePortal = true;
    autostart.enable = true;
  };
}
