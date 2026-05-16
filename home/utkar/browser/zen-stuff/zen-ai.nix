{config, ...}: let
  zen-work = config.programs.zen-browser.profiles."Dw3oaFqL.Profile 1".spaces."AI";
in {
  programs.zen-browser.profiles."Dw3oaFqL.Profile 1".pins = {
    "Ai" = {
      id = "0e04d166-0338-4971-862e-d4d924ed0e86";
      isGroup = true;
      editedTitle = true;
      isFolderCollapsed = true;
      position = 401;
      workspace = zen-work.id;
      container = 4;
    };
    "Mistral" = {
      id = "d4096d47-fcae-4aea-9356-acfb58f881bc";
      url = "https://console.mistral.ai/home";
      folderParentId = "0e04d166-0338-4971-862e-d4d924ed0e86";
      editedTitle = true;
      position = 402;
      container = 4;
    };

    "Google-AI-Studio" = {
      id = "0bdbf401-640d-43bb-946e-d39e472d600d";
      url = "https://aistudio.google.com/prompts/new_chat?pli=1";
      folderParentId = "0e04d166-0338-4971-862e-d4d924ed0e86";
      editedTitle = true;
      position = 403;
      container = 4;
    };
    "Claude" = {
      id = "d5646d76-4c71-4625-9832-2e71e6a5404e";
      url = "https://claude.ai/new";
      folderParentId = "0e04d166-0338-4971-862e-d4d924ed0e86";
      editedTitle = true;
      position = 404;
      container = 4;
    };
    "OpenRouter" = {
      id = "cc9eb243-b3d4-4747-aebd-9a3ce1b7ea1e";
      url = "https://openrouter.ai/";
      folderParentId = "0e04d166-0338-4971-862e-d4d924ed0e86";
      editedTitle = true;
      position = 405;
      container = 4;
    };
  };
}
