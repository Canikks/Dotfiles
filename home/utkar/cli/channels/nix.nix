{...}: {
  programs.television.channels = {
    nix = {
      metadata = {
        name = "nix";
        requirements = ["nix-search-tv"];
      };
      source = {
        command = "nix-search-tv print source homepage";
      };
      preview = {
        command = "nix-search-tv preview {}";
      };
    };
  };
}
