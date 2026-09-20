{pkgs, ...}: {
  # --- Desktop & XDG ---
  xdg = {
    autostart = {
      enable = true;
    };
    terminal-exec = {
      enable = true;
      settings = {
        GNOME = [
          "com.raggesilver.BlackBox.desktop"
          "org.gnome.Terminal.desktop"
        ];
        default = [
          "com.mitchellh.ghostty.desktop"
          "kitty.desktop"
        ];
      };
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-termfilechooser
      ];
      configPackages = [pkgs.niri-unstable];
      config = {
        common = {
          default = [
            "termfilechooser"
            "hyprland"
            "gnome"
            "gtk"
          ];
          # "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          "org.freedesktop.impl.portal.Settings" = [
            "kitty"
            "*"
          ];
          # "org.freedesktop.portal.ScreenCast" = [
          #   "gnome"
          # ];
          # "org.freedesktop.impl.portal.ScreenCast" = [
          #   "gnome"
          # ];
        };
        niri = {
          "org.freedesktop.impl.portal.Settings" = [
            "kitty"
            "*"
          ];
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          "org.freedesktop.impl.portal.Access" = [
            "gtk"
          ];
          "org.freedesktop.impl.portal.Notification" = [
            "gtk"
          ];
          "org.freedesktop.portal.ScreenCast" = [
            "gnome"
          ];
        };
      };
    };
  };
}
