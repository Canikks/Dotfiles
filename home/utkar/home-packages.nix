{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.kdePackages.qtmultimedia
    pkgs.hicolor-icon-theme
  ];
  home.sessionVariables.QML2_IMPORT_PATH = lib.concatStringsSep ":" [
    "${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml"
  ];
}
