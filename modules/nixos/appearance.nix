{ pkgs, config, ... }: {
  # --- Appearance & Fonts ---
  stylix.base16Scheme = "${config.users.users.utkar.home}/.config/DankMaterialShell/base16.yaml";
  qt.enable = true;
  appstream.enable = true;

  fonts = {
    enableGhostscriptFonts = true;
    enableDefaultPackages = true;
    fontconfig = {
      subpixel.rgba = "rgb";
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
    ];
    fontDir.enable = true;
    fontDir.decompressFonts = true;
  };

  # --- System state ---
  system.stateVersion = "25.05";
}