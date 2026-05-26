{
  programs.television.channels = {
    fish-history = {
      metadata = {
        name = "fish-history";
        requirements = ["fish"];
      };
      source = {
        command = "fish -c 'history'";
        sort_results = false;
      };
    };
  };
}
