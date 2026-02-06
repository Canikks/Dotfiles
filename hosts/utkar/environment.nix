{pkgs, ...}: {
  environment = {
    pathsToLink = ["/share/zsh" "/share/fish"];
    variables = {
      QML_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml:${pkgs.qt6.qtmultimedia}/lib/qt-6/qmt";
      QML2_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml:${pkgs.qt6.qtmultimedia}/lib/qt-6/qmt";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      NIXOS_OZONE_WL = "1";
      OZONE_PLATFORM = "wayland";
      STEAM_USE_NATIVE_LIBRARIES = "1";
      STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
      MOZ_ENABLE_WAYLAND = "1";
      GBM_BACKEND = "dri";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QS_ICON_THEME = "Papirus-dark";
      RUSTFLAGS = "-C link-arg=-Wl,--no-keep-memory";
      GTK_USE_PORTAL = "1";
      QT_QPA_PLATFORMTHEME = "xdgdesktopportal;gtk3";
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
