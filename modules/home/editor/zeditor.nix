{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "toml" "html" "kdl"];
    extraPackages = with pkgs; [
      nixd
      alejandra
    ];
    installRemoteServer = true;
    mutableUserDebug = true;
    mutableUserKeymaps = true;
    mutableUserSettings = true;
    # userSettings = {
    #   features = {
    #     edit_prediction_provider = "codestral";
    #   };
    # };
  };
}
