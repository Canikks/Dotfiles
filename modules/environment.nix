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
        "${pkgs.hicolor-icon-theme}/lib/qt-6/qml"
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
      "xdg/wayland-sessions/niri.desktop" = {
        text = ''
          [Desktop Entry]
          Name=Niri
          Comment=Niri Wayland Compositor
          Exec=${pkgs.dbus}/bin/dbus-run-session ${pkgs.niri}/bin/niri-session
          Type=Application
          DesktopNames=niri
        '';
      };
      # "xdg/gtk-2.0/gtkrc".text = ''
      #   gtk-icon-theme-name="hicolor"
      # '';
      # "xdg/gtk-3.0/settings.ini".text = ''
      #   [Settings]
      #   gtk-icon-theme-name=hicolor
      # '';
      # "xdg/gtk-4.0/settings.ini".text = ''
      #   [Settings]
      #   gtk-icon-theme-name=hicolor
      # '';
      # "xdg/icons/default/index.theme".text = ''
      #   [Icon Theme]
      #   Inherits=hicolor
      # '';
    };
  };
}
