{
  config,
  profileName,
  ...
}: let
  zenWork =
    config.programs.zen-browser.profiles.${profileName}.spaces."Pirate";

  pirateFolderId = "f73cc43e-86fd-4bea-b956-7f95f3602f61";

  mkPiratePin = {
    url,
    id,
    position,
  }: {
    inherit url id position;

    folderParentId = pirateFolderId;

    editedTitle = true;
    container = 5;
  };
in {
  programs.zen-browser.profiles.${profileName}.pins =
    {
      Pirate = {
        id = pirateFolderId;

        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = true;

        position = 501;
        workspace = zenWork.id;
        container = 5;
      };
    }
    // {
      Island = mkPiratePin {
        url = "https://www.reddit.com/r/Piracy/wiki/megathread/";
        id = "9c4b8ac3-d8d4-4f36-bb4d-3f29ed53e8c9";
        position = 502;
      };
    };
}
