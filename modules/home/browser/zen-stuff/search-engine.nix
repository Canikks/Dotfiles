{profileName, ...}: {
  programs.zen-browser.profiles.${profileName}.search = {
    force = true;
    default = "Myxng";
    engines = {
      Myxng = {
        name = "Myxng";
        urls = [
          {
            template = "http://127.0.0.1:8080/search?q={searchTerms}";
          }
        ];
        definedAliases = ["@mxng"];
      };
    };
  };
}
