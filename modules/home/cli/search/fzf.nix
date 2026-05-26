{
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    tmux.enableShellIntegration = true;
    fileWidgetOptions = [
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
    fileWidgetCommand = "fd --type f";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -200'"
    ];
    changeDirWidgetCommand = "fd --type d";
    historyWidgetOptions = ["--sort" "--exact"];
  };
}
