{...}: {
  programs.zen-browser.profiles."Dw3oaFqL.Profile 1".search = {
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
