{profileName, ...}: {
  programs.zen-browser.profiles.${profileName}.search = {
    force = true;
    default = "MyXNG";
    engines = {
      MyXNG = {
        name = "MyXNG";
        urls = [
          {
            template = "https://utkar.tail8ffd43.ts.net/search?q={searchTerms}";
          }
        ];
        definedAliases = ["@mxng"];
      };
    };
  };
}
