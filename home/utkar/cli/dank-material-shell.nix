{...}: {
  programs.dank-material-shell.settings = {
    theme = "dark";
    dynamicTheming = true;
  };
  programs.dank-material-shell.plugins = {
    dockerManager.enable = true;
    mediaPlayer.enable = true;
    commandRunner.enable = true;
    dankLauncherKeys.enable = true;
    easyEffects.enable = true;
    niriWindows.enable = true;
    webSearch.enable = true;
    dankDesktopWeather.enable = true;
    dankKDEConnect.enable = true;
    nixMonitor.enable = true;
    dankClight.enable = true;
    dankNotepadModule.enable = true;
  };
}
