{config, ...}: let
  zen-work = config.programs.zen-browser.profiles."Dw3oaFqL.Profile 1".spaces."Pirate";
in {
  programs.zen-browser.profiles."Dw3oaFqL.Profile 1".pins = {
    "Pirate" = {
      id = "f73cc43e-86fd-4bea-b956-7f95f3602f61";
      isGroup = true;
      editedTitle = true;
      isFolderCollapsed = true;
      position = 501;
      workspace = zen-work.id;
      container = 5;
    };
    "Island" = {
      id = "9c4b8ac3-d8d4-4f36-bb4d-3f29ed53e8c9";
      url = "https://www.reddit.com/r/Piracy/wiki/megathread/";
      folderParentId = "f73cc43e-86fd-4bea-b956-7f95f3602f61";
      editedTitle = true;
      position = 502;
      container = 5;
    };
  };
}
