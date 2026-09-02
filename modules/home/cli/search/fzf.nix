{
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    enableNushellIntegration = true;
    tmux.enableShellIntegration = true;
    # defaultOptions = ["--popup"];
    fileWidget = {
      options = [
        "--popup --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
      ];
      command = "fd --type f";
    };
    changeDirWidget = {
      options = [
        "--popup --preview 'tree -C {} | head -200'"
      ];
      command = "fd --type d";
    };
    historyWidget.options = ["--sort" "--exact" "--popup"];
  };
}
