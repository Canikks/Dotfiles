{
  pkgs,
  inputs,
  system,
  ...
}: {
  programs.dsearch = {
    enable = true;
    package = inputs.dsearch.packages.${system}.default;
    config = {
      index_all_files = false;
      # index_path = ".cache/danksearch/index";
      listen_addr = ":43654";
      auto_reindex = false;
      reindex_interval_hours = 72;
      # max_depth = 0;
      max_file_bytes = 2097152;
      text_extentions = [
        ".txt"
        ".md"
        ".go"
        ".py"
        ".js"
        ".ts"
        ".jsx"
        ".tsx"
        ".json"
        ".yaml"
        ".yml"
        ".toml"
        ".html"
        ".css"
        ".rs"
        ".c"
        ".cpp"
        ".h"
        ".java"
        ".rb"
        ".php"
        ".sh"
        ".nix"
        ".conf"
      ];
      worker_count = 1;
      index_paths = [
        {
          exclude_dirs = [
            ".git"
            "node_modules"
            "bower_components"
            ".npm"
            ".yarn"
            "site-packages"
            "__pycache__"
            ".venv"
            "venv"
            ".tox"
            ".pytest_cache"
            ".eggs"
            "dist"
            "build"
            "out"
            "bin"
            "obj"
            "target"
            "vendor"
            ".gradle"
            ".m2"
            "bundle"
            ".cache"
            ".parcel-cache"
            ".next"
            ".nuxt"
            ".serverless"
            "Library"
            ".Trash-1000"
            ".postgresql"
            ".postgres"
            ".mysql"
            ".mongodb"
            ".redis"
            "pgdata"
            "pg_data"
            "go"
            ".cargo"
            ".pyenv"
            ".rbenv"
            ".nvm"
            ".rustup"
            ".composer"
            ".gem"
            ".idea"
            ".vscode"
            ".zen"
            "lesshsQ"
            "app.zen_browser.zen"
            "lesshst"
            "Hollow.Knight.Silksong.v1.0.28497"
            "Noita.v25.01.2025"
            "Dead.Cells.v35.7"
            "Hollow.Knight.v1.5.78"
            "Starsector"
            "Games"
            ".steampath"
            "secrets"
            ".config"
            "dotfiles-snowfall"
            "dotfiles"
          ];
          exclude_hidden = true;
          extract_exif = true;
          max_depth = 0;
          path = "/home/utkar";
        }
        {
          exclude_dirs = [
            "chromium"
            "chromium-backup"
            "net.imput.helium"
            "zen"
            "grammars"
            "vesktop"
            ".devenv"
            "firefox"
          ];
          max_depth = 0;
          path = "/home/utkar/.config";
        }
        {
          exclude_hidden = false;
          max_depth = 0;
          path = "/home/utkar/dotfiles";
          exclude_dirs = [
            ".git"
            ".jj"
            ".direnv"
            "secrets"
            ".devenv"
          ];
        }
      ];
    };
  };
}
