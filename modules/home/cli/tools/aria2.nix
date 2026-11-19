{
  programs.aria2 = {
    enable = false;
    systemd.enable = true;
    settings = {
      max-connection-per-server = 16;
      split = 16;
      min-split-size = "4M";
      file-allocation = "falloc";
      console-log-level = "error";
      summary-interval = 0;
      show-console-readout = false;
    };
  };
  programs.aria2p = {
    enable = false;
  };
}
