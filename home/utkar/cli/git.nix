{...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "canicks@proton.me";
        name = "Canikks";
      };
      delta = {
        navigate = true;
        dark = true;
        side-by-side = true;
      };
      merge = {
        conflictStyle = "zdiff3";
      };
    };
  };
}
