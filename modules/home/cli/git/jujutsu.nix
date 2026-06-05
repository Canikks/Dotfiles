{
  programs.jujutsu = {
    enable = true;
    settings.user = {
      email = "canicks@proton.me";
      name = "Canikks";
    };
    settings.delta = {
      navigate = true;
      dark = true;
      side-by-side = true;
    };
    settings.ui = {
      diff-editor = ":builtin";
    };
  };
}
