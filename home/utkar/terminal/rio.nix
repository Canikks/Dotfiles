{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.rio = {
    enable = true;
    themes = {
      base16 = {
        colors = {
          background = "#181818";
          foreground = "#d8d8d8";
          cursor = "#d8d8d8";
          vi-cursor = "#d8d8d8";
          selection-background = "#383838";
          selection-foreground = "#d8d8d8";
          search-match-background = "#f7ca88";
          search-match-foreground = "#181818";
          search-focused-match-background = "#ab4642";
          search-focused-match-foreground = "#181818";
          tabs = "#383838";
          tabs-active = "#181818";
          black = "#181818";
          red = "#ab4642";
          green = "#a1b56c";
          yellow = "#f7ca88";
          blue = "#7cafc2";
          magenta = "#ba8baf";
          cyan = "#86c1b9";
          white = "#d8d8d8";
          light-black = "#585858";
          light-red = "#dc9656";
          light-green = "#282828";
          light-yellow = "#383838";
          light-blue = "#b8b8b8";
          light-magenta = "#e8e8e8";
          light-cyan = "#a16946";
          light-white = "#f8f8f8";
        };
      };
    };
    settings = {
      theme = "base16";
      confirm-before-quit = false;
      window = {
        opacity = 0.8;
        colorspace = "srgb";
      };
      renderer = {
        backend = "automatic";
        performance = "high";
        level = 1;
      };
      editor = {
        program = "hx";
      };
    };
  };
}
