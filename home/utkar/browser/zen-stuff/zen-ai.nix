{
  config,
  profileName,
  ...
}: let
  zenWork =
    config.programs.zen-browser.profiles.${profileName}.spaces."AI";

  aiFolderId = "0e04d166-0338-4971-862e-d4d924ed0e86";

  mkAiPin = {
    url,
    id,
    position,
  }: {
    inherit url id position;

    folderParentId = aiFolderId;

    editedTitle = true;
    container = 4;
  };
in {
  programs.zen-browser.profiles.${profileName}.pins =
    {
      Ai = {
        id = aiFolderId;

        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = true;

        position = 401;
        workspace = zenWork.id;
        container = 4;
      };
    }
    // {
      Mistral = mkAiPin {
        url = "https://console.mistral.ai/home";
        id = "d4096d47-fcae-4aea-9356-acfb58f881bc";
        position = 402;
      };

      Google-AI-Studio = mkAiPin {
        url = "https://aistudio.google.com/prompts/new_chat?pli=1";
        id = "0bdbf401-640d-43bb-946e-d39e472d600d";
        position = 403;
      };

      Claude = mkAiPin {
        url = "https://claude.ai/";
        id = "d5646d76-4c71-4625-9832-2e71e6a5404e";
        position = 404;
      };

      OpenRouter = mkAiPin {
        url = "https://openrouter.ai/";
        id = "cc9eb243-b3d4-4747-aebd-9a3ce1b7ea1e";
        position = 405;
      };
    };
}
