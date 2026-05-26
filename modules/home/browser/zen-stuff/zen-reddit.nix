{
  config,
  profileName,
  ...
}: let
  zenWork =
    config.programs.zen-browser.profiles.${profileName}.spaces."Reddit";

  redditFolderId = "80d4e296-2e9c-43fb-bf98-341347f36e7c";

  mkRedditPin = {
    subreddit,
    id,
    position,
  }: {
    inherit id position;

    url = "https://reddit.com/r/${subreddit}/";

    folderParentId = redditFolderId;

    editedTitle = true;
    container = 3;
  };
in {
  programs.zen-browser.profiles.${profileName}.pins =
    {
      Reddit = {
        id = redditFolderId;

        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = true;

        position = 201;
        workspace = zenWork.id;
        container = 3;
      };
    }
    // {
      Niri = mkRedditPin {
        subreddit = "niri";
        id = "8c72ca26-552d-4b58-9d54-d0107885c7bb";
        position = 202;
      };

      India = mkRedditPin {
        subreddit = "india";
        id = "f208ecc1-6f0d-40b4-bdfc-394d41396739";
        position = 203;
      };

      Arc = mkRedditPin {
        subreddit = "ArcBrowser";
        id = "9de27f13-3276-437b-933c-84713c525dda";
        position = 204;
      };

      Zen-browser = mkRedditPin {
        subreddit = "zen_browser";
        id = "f00e2419-30a2-4667-a890-a38b86a537f0";
        position = 205;
      };

      NixOS = mkRedditPin {
        subreddit = "NixOS";
        id = "73b60294-1468-4bc3-9c6a-baefe2083e0c";
        position = 206;
      };

      Browser = mkRedditPin {
        subreddit = "browsers";
        id = "986c6a0a-3e61-4d4a-8ebe-f5ed4b39f25c";
        position = 207;
      };
    };
}
