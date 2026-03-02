{...}: {
  programs.television.channels = {
    text = {
      metadata = {
        name = "text";
        description = "A channel to find and select text from files";
        requirements = [
          "rga"
          "bat"
        ];
      };

      source = {
        command = ["rga . --no-heading --line-number --colors 'match:fg:white' --colors 'path:fg:blue' --color=always" "rga . --no-heading --line-number --hidden --colors 'match:fg:white' --colors 'path:fg:blue' --color=always"];
        ansi = true;
        output = "{strip_ansi|split:\\::..2}";
      };

      preview = {
        command = "bat -n --color=always '{strip_ansi|split:\\::0}'";
        offset = "{strip_ansi|split:\\::1}";
      };

      keybindings = {
        enter = "actions:edit";
      };

      preview.env = {
        BAT_THEME = "ansi";
      };

      ui.preview_panel = {
        header = "{strip_ansi|split:\\::..2}";
      };

      actions = {
        edit = {
          description = "Open match in Helix";
          command = "hx '+{strip_ansi|split:\\::1}' '{strip_ansi|split:\\::0}'";
          shell = "bash";
          mode = "execute";
        };
      };
    };
  };
}
