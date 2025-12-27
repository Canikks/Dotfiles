{...}: {
  programs.rio = {
    enable = true;
    settings = {
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
