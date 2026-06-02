{
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    tmux.enableShellIntegration = true;
    defaultOptions = ["--popup"];
    fileWidgetOptions = [
      "--preview --popup 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
    fileWidgetCommand = "fd --type f";
    changeDirWidgetOptions = [
      "--preview --popup 'tree -C {} | head -200'"
    ];
    changeDirWidgetCommand = "fd --type d";
    historyWidgetOptions = ["--sort" "--exact" "--popup"];
  };
}
