{profileName, ...}: {
  programs.zen-browser.profiles.${profileName}.spaceRouting = {
    force = true;
    routes = {
      "Nix" = {
        openIn = "c5aa96a0-3d36-4f66-9c1a-80d8988b1b42";
        matchType = "contains";
        reference = "nix";
      };
      "Chatgpt" = {
        openIn = "03383203-eacc-41dd-ad7c-3db0597c4bf7";
        matchType = "contains";
        reference = "chatgpt";
      };
      "Reddit" = {
        openIn = "fffc3cab-54b3-4d28-a1fd-e194c29b7564";
        matchType = "contains";
        reference = "reddit";
      };
      "Claude" = {
        openIn = "03383203-eacc-41dd-ad7c-3db0597c4bf7";
        matchType = "contains";
        reference = "claude";
      };
      "Flake" = {
        openIn = "c5aa96a0-3d36-4f66-9c1a-80d8988b1b42";
        matchType = "contains";
        reference = "flake";
      };
      "Openrouter" = {
        openIn = "03383203-eacc-41dd-ad7c-3db0597c4bf7";
        matchType = "contains";
        reference = "openrouter";
      };
    };
  };
}
