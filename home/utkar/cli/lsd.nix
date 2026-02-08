{...}: {
  programs.lsd = {
    enable = true;
    enableAliases = true;
    enableFishIntegration = true;
    settings = {
      date = "relative";
      ignore-globs = [".git"];
      hyperlink = "always";
    };
  };
}
