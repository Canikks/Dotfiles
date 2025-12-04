{
  config,
  pkgs,
  ...
}: {
  programs.aria2 = {
    enable = true;
    settings = {
      enable-rpc = true;
      max-connection-per-server = 16;
      split = 16;
      min-split-size = "4M";
      file-allocation = "falloc";
      console-log-level = "error";
      summary-interval = 0;
      show-console-readout = true;
      rpc-allow-origin-all = true;
    };
  };
}
