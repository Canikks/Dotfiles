{pkgs}: {
  programs.tmux = {
    enable = true;

    package = pkgs.tmux;

    shell = "${pkgs.zsh}/bin/zsh";

    terminal = "tmux-256color";

    historyLimit = 100000;
    escapeTime = 10;

    baseIndex = 1;
    keyMode = "vi";

    mouse = false;
    focusEvents = true;

    sensibleOnTop = true;

    extraConfig = ''
      ##### Terminal / Ghostty #####

      set -g default-terminal "tmux-256color"

      set -as terminal-features ",xterm-ghostty:RGB"
      set -as terminal-features ",xterm-ghostty:clipboard"
      set -as terminal-features ",tmux-256color:RGB"

      set -s extended-keys on
      set -g focus-events on

      ##### Clipboard #####

      set -g set-clipboard on

      ##### General UX #####

      setw -g mode-keys vi

      set -g renumber-windows on
      set -g detach-on-destroy off

      set -g display-panes-time 1200
      set -g display-time 2000

      ##### Splits #####

      unbind %
      bind | split-window -h -c "#{pane_current_path}"

      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      bind c new-window -c "#{pane_current_path}"

      ##### Pane Navigation #####

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      ##### Resize #####

      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      ##### Reload #####

      bind r source-file ~/.config/tmux/tmux.conf \; \
        display-message "tmux reloaded"

      ##### Popup shell #####

      bind-key p popup -E \
        -w 80% \
        -h 80% \
        -d "#{pane_current_path}" \
        "${pkgs.zsh}/bin/zsh"

      ##### Sessionizer #####

      bind-key f popup -E \
        -w 80% \
        -h 80% \
        "~/.local/bin/tmux-sessionizer"

      ##### Helix file picker #####

      bind-key o run-shell "~/.local/bin/tmux-hx-picker"

      ##### Extrakto #####

      set -g @extrakto_launch_key "e"
      set -g @extrakto_split_direction "v"
      set -g @extrakto_grab_area "full"
      set -g @extrakto_clip_tool "wl-copy"
      set -g @extrakto_fzf_tool "fzf"

      ##### URL picker #####

      set -g @fzf-url-bind "u"

      ##### Status bar #####

      set -g status-position top
      set -g status-justify left

      set -g status-style "bg=default,fg=default"

      set -g status-left-length 100
      set -g status-right-length 140

      # Slanted/powerline-like separators
      set -g status-left ""
      set -g status-right ""

      set -g window-status-separator ""

      # Inactive windows
      set -g window-status-format \
        "#[fg=colour8,bg=default] #[fg=default,bg=colour8] #I #W #[fg=colour8,bg=default]"

      # Active window
      set -g window-status-current-format \
        "#[fg=colour4,bg=default] #[fg=colour0,bg=colour4,bold] #I #W #[fg=colour4,bg=default]"

      # Right side
      set -g status-right \
        "#[fg=colour2,bg=default]#[fg=colour0,bg=colour2] #(whoami) #[fg=colour2,bg=default] \
         #[fg=colour5,bg=default]#[fg=colour0,bg=colour5] #{pane_current_path} #[fg=colour5,bg=default] \
         #[fg=colour6,bg=default]#[fg=colour0,bg=colour6] %H:%M #[fg=colour6,bg=default]"

      ##### Better copy mode #####

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel

      ##### Smoothness #####

      set -g assume-paste-time 1

      ##### Activity #####

      setw -g monitor-activity on
      set -g visual-activity off
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible

      yank
      prefix-highlight
      cpu
      battery
      online-status
      better-mouse-mode
      logging
      fzf-tmux-url

      {
        plugin = extrakto;
      }

      # Theme plugin WITHOUT forcing colors
      # lets tmux inherit Ghostty terminal palette
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"

          # Important:
          # don't override terminal palette aggressively
          set -g @catppuccin_window_status_style "rounded"

          set -g @catppuccin_status_background "default"
          set -g @catppuccin_pane_status_enabled "off"
        '';
      }

      # Put persistence LAST
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents "on"
          set -g @resurrect-processes "ssh zsh hx"

          set -g @resurrect-strategy-hx "session"
        '';
      }

      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore "on"
          set -g @continuum-save-interval "15"
        '';
      }
    ];
  };

  home.packages = with pkgs; [
    fzf
    fd
    ripgrep
    zoxide
    wl-clipboard
    xclip
  ];

  ##### Sessionizer #####

  home.file.".local/bin/tmux-sessionizer" = {
    executable = true;

    text = ''
      #!/usr/bin/env bash

      selected=$(
        find \
          ~/Code \
          ~/Projects \
          ~/.config \
          ~/Downloads \
          -mindepth 1 \
          -maxdepth 3 \
          -type d 2>/dev/null | \
        fzf \
          --height 40% \
          --layout reverse \
          --border
      )

      [ -z "$selected" ] && exit 0

      tmux send-keys "$selected"
    '';
  };

  ##### Helix picker #####

  home.file.".local/bin/tmux-hx-picker" = {
    executable = true;

    text = ''
      #!/usr/bin/env bash

      selected=$(
        tmux capture-pane -pS -3000 | \
        grep -oE '([[:alnum:]_./~-]+\.[[:alnum:]]+)' | \
        sort -u | \
        fzf \
          --height 40% \
          --layout reverse \
          --border
      )

      [ -z "$selected" ] && exit 0

      tmux new-window -c "#{pane_current_path}" "hx $selected"
    '';
  };

  ##### Shell integration #####

  programs.fzf.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      export EDITOR=hx
      export VISUAL=hx

      # Better truecolor support
      export COLORTERM=truecolor

      # Faster fzf defaults
      export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"

      # Cleaner tmux startup
      if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]]; then
        exec tmux
      fi
    '';
  };
}
