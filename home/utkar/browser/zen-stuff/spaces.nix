{profileName, ...}:{
  programs.zen-browser.profiles.${profileName} = {
    spaces = {
      "Home" = {
        id = "7b455a24-8438-46da-8682-631ce274b2fc";
        icon = "🏡";
        position = 1000;
        container = 1;
      };
      "Reddit" = {
        id = "fffc3cab-54b3-4d28-a1fd-e194c29b7564";
        icon = "🎮";
        position = 2000;
        container = 3;
      };
      "Nix" = {
        id = "c5aa96a0-3d36-4f66-9c1a-80d8988b1b42";
        icon = "❄️";
        position = 3000;
      };
      "AI" = {
        id = "03383203-eacc-41dd-ad7c-3db0597c4bf7";
        icon = "🤖";
        position = 4000;
        container = 4;
      };
      "Pirate" = {
        id = "42628f8d-0ff9-4d47-adf7-d5322fde01fb";
        icon = "🏴‍☠️";
        position = 5000;
        container = 5;
      };
    };
  };
}
