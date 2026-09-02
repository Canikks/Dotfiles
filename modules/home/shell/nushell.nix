{lib, ...}: {
  programs.nushell = {
    enable = true;
    configFile = {
      # text = ''
      #   $env.config.filesize_metric = false
      #   $env.config.table_mode = 'rounded'
      #   $env.config.use_ls_colors = true
      # '';
    };
  };
}
