{lib, ...}: {
  programs.nushell = {
    enable = true;
    configFile = {
      text = ''
        const NU_LIB_DIRS = $NU_LIB_DIRS ++ ${
          lib.hm.nushell.toNushell (lib.concatStringsSep ":" [./scripts])
        }
        $env.config.filesize_metric = false
        $env.config.table_mode = 'rounded'
        $env.config.use_ls_colors = true
      '';
    };
  };
}
