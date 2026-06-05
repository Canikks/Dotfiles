{
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    tmux.enableShellIntegration = true;
    # defaultOptions = ["--popup"];
    fileWidgetOptions = [
      "--popup --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
    # fileWidgetCommand = "fd --type f";
    changeDirWidgetOptions = [
      "--popup --preview 'tree -C {} | head -200'"
    ];
    changeDirWidgetCommand = "fd --type d";
    historyWidgetOptions = ["--sort" "--exact" "--popup"];
  };
}
