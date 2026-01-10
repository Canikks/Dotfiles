{...}: {
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    fileWidgetOptions = [
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -200'"
    ];
  };
}
