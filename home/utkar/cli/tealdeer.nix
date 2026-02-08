{...}: {
  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
    settings = {
      updates.auto_update = false;
      updates.auto_update_interval_hours = 24;
    };
  };
}
