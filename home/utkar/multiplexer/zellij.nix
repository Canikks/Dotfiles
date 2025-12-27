{...}: {
  programs.zellij = {
    enable = true;
    # enableZshIntegration = true;
    enableFishIntegration = true;
    attachExistingSession = true;
    exitShellOnExit = true;
  };
}
