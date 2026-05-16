{config, ...}: let
  zen-work = config.programs.zen-browser.profiles."Dw3oaFqL.Profile 1".spaces."Nix";
in {
  programs.zen-browser.profiles."Dw3oaFqL.Profile 1".pins = {
    "Nix" = {
      id = "ad0e571c-9d2c-4775-8813-c3094e32e3b6";
      isGroup = true;
      isFolderCollapsed = true;
      editedTitle = true;
      position = 301;
      workspace = zen-work.id;
    };
    "Awesome-nix" = {
      id = "e2d50146-4942-420e-8cb3-6204a2fc87ed";
      url = "https://github.com/nix-community/awesome-nix";
      folderParentId = "ad0e571c-9d2c-4775-8813-c3094e32e3b6";
      editedTitle = true;
      position = 302;
    };
    "MyNixOS" = {
      id = "2e4eca4b-7ed1-4173-9b69-35b5271d80cb";
      url = "https://mynixos.com/";
      folderParentId = "ad0e571c-9d2c-4775-8813-c3094e32e3b6";
      editedTitle = true;
      position = 303;
    };
    "Home-Manager" = {
      id = "5ddab755-9577-4400-ac0a-2b2a7d53d078";
      url = "https://nix-community.github.io/home-manager/index.xhtml";
      folderParentId = "ad0e571c-9d2c-4775-8813-c3094e32e3b6";
      editedTitle = true;
      position = 304;
    };
    "NixOS Options" = {
      id = "13589a1e-ab00-4003-af17-5c78e8b072f8";
      url = "https://search.nixos.org/packages?channel=unstable";
      folderParentId = "ad0e571c-9d2c-4775-8813-c3094e32e3b6";
      editedTitle = true;
      position = 305;
    };
    "Nix Projects" = {
      id = "3f8d95dc-0ea3-4f7a-83b6-fae7ee59a651";
      isGroup = true;
      editedTitle = true;
      position = 306;
      isFolderCollapsed = true;
      workspace = zen-work.id;
    };
    "Nix-Cachyos-Kernel" = {
      id = "80e44634-e116-445b-816b-db2a4de12a04";
      url = "https://github.com/xddxdd/nix-cachyos-kernel";
      folderParentId = "3f8d95dc-0ea3-4f7a-83b6-fae7ee59a651";
      editedTitle = true;
      position = 307;
    };
    "Nixos-cli" = {
      id = "460dc9d6-03b3-4011-a66b-a8c805fd4108";
      url = "https://github.com/nix-community/nixos-cli";
      folderParentId = "3f8d95dc-0ea3-4f7a-83b6-fae7ee59a651";
      editedTitle = true;
      position = 307;
    };
  };
}
