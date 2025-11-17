{
  config,
  pkgs,
  lib,
  ...
}: {
  environment = {
    pathsToLink = ["/share/zsh"];
    variables = {
      QML2_IMPORT_PATH = lib.concatStringsSep ":" [
        "${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml"
      ];
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXOS_OZONE_WL = "1";
      OZONE_PLATFORM = "wayland";
      STEAM_USE_NATIVE_LIBRARIES = "1";
      STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
    };
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      TERMINAL = "ghostty";
    };
    etc = {
      "polkit-1/rules.d/10-udisks2.rules" = {
        text = ''
          polkit.addRule(function(action, subject) {
            if ((action.id.indexOf("org.freedesktop.udisks2.") == 0) &&
                subject.isInGroup("wheel")) {
              return polkit.Result.YES;
            }
          });
        '';
      };
    };
  };
}
