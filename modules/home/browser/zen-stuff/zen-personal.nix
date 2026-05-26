{
  config,
  profileName,
  ...
}: let
  zenWork =
    config.programs.zen-browser.profiles.${profileName}.spaces."Home";

  personalFolderId = "5aa9b844-0efc-4462-8c1d-054f77abebab";

  mkPersonalPin = {
    url,
    id,
    position,
  }: {
    inherit url id position;

    folderParentId = personalFolderId;

    editedTitle = true;
    container = 1;
  };
in {
  programs.zen-browser.profiles.${profileName}.pins =
    {
      Personal = {
        id = personalFolderId;

        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = true;

        position = 102;
        workspace = zenWork.id;
        container = 1;
      };

      Youtube = {
        id = "e72a0083-7dd5-4a7d-a8f1-15e4823dee09";
        url = "https://www.youtube.com/";

        editedTitle = true;

        position = 101;

        isEssential = true;
        container = 1;
      };
    }
    // {
      WhatsApp = mkPersonalPin {
        url = "https://web.whatsapp.com/";
        id = "93ae85c5-39e6-4ba9-9bc4-a7b0f84fab2f";
        position = 103;
      };

      Dotfiles = mkPersonalPin {
        url = "https://codeberg.org/Canix/dotfiles";
        id = "e94a2ed3-4d3a-4036-b60b-99cf2e40b455";
        position = 104;
      };

      Email = mkPersonalPin {
        url = "https://mail.proton.me/u/0/inbox";
        id = "5b51393b-7bfb-46ab-ba70-eff78196f004";
        position = 105;
      };
    };
}
