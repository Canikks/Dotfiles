{pkgs, ...}: {
  environment = {
    enableAllTerminfo = true;
    localBinInPath = true;
    pathsToLink = ["/share/zsh" "/share/fish"];

    sessionVariables = {
      # --- Graphics & Wayland ---
      LIBVA_DRIVER_NAME = "iHD";
      VPL_PLATFORM_IMPLEMENTATION_TYPE = "HW";
      NIXOS_OZONE_WL = 1;
      OZONE_PLATFORM = "wayland";
      GBM_BACKEND = "dri";
      GTK_USE_PORTAL = 1;

      # --- Qt & GTK Configuration ---
      QML_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml:${pkgs.qt6.qtmultimedia}/lib/qt-6/qmt";
      QML2_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml:${pkgs.qt6.qtmultimedia}/lib/qt-6/qmt";
      QT_PLUGIN_PATH = "${pkgs.qt5.qtbase}/lib/qt-5.${pkgs.qt5.qtbase.version}/plugins";
      QT_QPA_PLATFORM = "wayland:xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
      QS_ICON_THEME = "Papirus-Dark";

      # --- Security & Certificates ---
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";

      # --- Application Specific ---
      STEAM_USE_NATIVE_LIBRARIES = 1;
      STEAM_RUNTIME_PREFER_HOST_LIBRARIES = 1;
      MOZ_ENABLE_WAYLAND = 1;
      MOZ_LEGACY_PROFILES = 0;
      APP2UNIT_SLICES = "a=app.slice b=background.slice s=session.slice";
    };
  };
}
