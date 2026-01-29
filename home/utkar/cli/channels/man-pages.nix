{...}: {
  programs.television.channels = {
    man-pages = {
      metadata = {
        name = "man-pages";
        description = "Browse and preview system manual pages";
        requirements = [
          "apropos"
          "man"
          "col"
        ];
      };

      source = {
        command = "apropos .";
      };

      preview = {
        command = "man '{0}' | col -bx";
        env = {
          MANWIDTH = "80";
        };
      };

      keybindings = {
        enter = "actions:open";
      };

      actions = {
        open = {
          description = "Open the selected man page in the system pager";
          command = "man '{0}'";
          mode = "execute";
        };
      };

      ui = {
        preview_panel = {
          header = "{0}";
        };
      };
    };
  };
}
