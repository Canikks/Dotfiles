{ config, profileName, ... }:

let
  zenWork =
    config.programs.zen-browser.profiles.${profileName}.spaces."Nix";

  nixFolderId = "ad0e571c-9d2c-4775-8813-c3094e32e3b6";

  nixProjectsFolderId = "3f8d95dc-0ea3-4f7a-83b6-fae7ee59a651";

  mkFolder =
    {
      id,
      position,
    }:
    {
      inherit id position;

      isGroup = true;
      isFolderCollapsed = true;
      editedTitle = true;

      workspace = zenWork.id;
    };

  mkPinnedTab =
    {
      url,
      id,
      position,
      folderId ? null,
    }:
    {
      inherit url id position;

      editedTitle = true;
    }
    // (
      if folderId != null then {
        folderParentId = folderId;
      } else {
      }
    );

in {
  programs.zen-browser.profiles.${profileName}.pins = {
    Nix = mkFolder {
      id = nixFolderId;
      position = 301;
    };

    Awesome-nix = mkPinnedTab {
      url = "https://github.com/nix-community/awesome-nix";
      id = "e2d50146-4942-420e-8cb3-6204a2fc87ed";
      position = 302;
      folderId = nixFolderId;
    };

    MyNixOS = mkPinnedTab {
      url = "https://mynixos.com/";
      id = "2e4eca4b-7ed1-4173-9b69-35b5271d80cb";
      position = 303;
      folderId = nixFolderId;
    };

    Home-Manager = mkPinnedTab {
      url = "https://nix-community.github.io/home-manager/index.xhtml";
      id = "5ddab755-9577-4400-ac0a-2b2a7d53d078";
      position = 304;
      folderId = nixFolderId;
    };

    "NixOS Options" = mkPinnedTab {
      url = "https://search.nixos.org/packages?channel=unstable";
      id = "13589a1e-ab00-4003-af17-5c78e8b072f8";
      position = 305;
      folderId = nixFolderId;
    };

    "Nix Projects" = mkFolder {
      id = nixProjectsFolderId;
      position = 306;
    };

    Nix-Cachyos-Kernel = mkPinnedTab {
      url = "https://github.com/xddxdd/nix-cachyos-kernel";
      id = "80e44634-e116-445b-816b-db2a4de12a04";
      position = 307;
      folderId = nixProjectsFolderId;
    };

    Nixos-cli = mkPinnedTab {
      url = "https://github.com/nix-community/nixos-cli";
      id = "460dc9d6-03b3-4011-a66b-a8c805fd4108";
      position = 308;
      folderId = nixProjectsFolderId;
    };
  };
}
