{config, ...}: {
  environment = {
    pathsToLink = ["/share/zsh" "/share/fish"];
    variables = {
      # QML2_IMPORT_PATH = lib.concatStringsSep ":" [
      #   "${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml"
      # ];
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      NIXOS_OZONE_WL = "1";
      OZONE_PLATFORM = "wayland";
      STEAM_USE_NATIVE_LIBRARIES = "1";
      STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
      MOZ_ENABLE_WAYLAND = "1";
    };
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
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
