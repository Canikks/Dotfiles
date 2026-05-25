{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    package = pkgs.tmux;

    shell = "${pkgs.zsh}/bin/zsh";

    terminal = "tmux-256color";

    prefix = "C-a";

    historyLimit = 100000;
    escapeTime = 10;

    baseIndex = 1;
    keyMode = "vi";

    mouse = false;
    focusEvents = true;

    # sensibleOnTop = true;

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

            set -g @floax-bind "p"

            ##### Extrakto #####

            set -g @extrakto_split_direction "v"
            set -g @extrakto_grab_area "full"
            set -g @extrakto_clip_tool "wl-copy"
            set -g @extrakto_fzf_tool "fzf"

            ##### URL picker #####

            set -g @fzf-url-bind "u"

            ##### Status bar #####

            # Refresh faster
            set -g status-interval 2

            # Let terminal theme control colors
            set -g status-style "bg=default,fg=default"

            ##### Powerline separators #####

            set -g pane-border-style "fg=colour238"
            set -g pane-active-border-style "fg=colour111"

            ##### Left side #####

            set -g status-left-length 100

            set -g status-left "#[fg=colour0,bg=colour111,bold] #S #[fg=colour111,bg=default,nobold]"

            ##### Right side #####

            set -g status-right-length 400

            # CPU
            set -g @cpu_low_icon "󰾆 "
            set -g @cpu_medium_icon "󰓅 "
            set -g @cpu_high_icon "󰓅 "

            # Battery
            set -g @batt_icon_full_charge "󰁹"
            set -g @batt_icon_charge_tier8 "󰂂"
            set -g @batt_icon_charge_tier7 "󰂁"
            set -g @batt_icon_charge_tier6 "󰂀"

            set -g status-right "\
      #[fg=colour111,bg=default]#[fg=colour0,bg=colour111] #(free | awk '/Mem:/ {printf \"󰍛 %d%%\", $3/$2 * 100.0}') \
      #[fg=colour147,bg=colour111]#[fg=colour0,bg=colour147] #(df -h / | awk 'NR==2 {print \"󰋊 \" $5}') \
      #[fg=colour186,bg=colour147]#[fg=colour0,bg=colour186] #{cpu_percentage} \
      #[fg=colour215,bg=colour186]#[fg=colour0,bg=colour215] #{battery_icon} #{battery_percentage} #{battery_remain} \
      #[fg=colour39,bg=colour215]#[fg=colour0,bg=colour39] %H:%M \
      #[fg=colour39,bg=default]"

            bind -T copy-mode-vi v send -X begin-selection
            bind -T copy-mode-vi y send -X copy-selection-and-cancel

            ##### Smoothness #####

            set -g assume-paste-time 1

            ##### Activity #####

            setw -g monitor-activity on
            set -g visual-activity off
    '';

    plugins = with pkgs.tmuxPlugins; [
      tmux-floax
      tmux-fzf
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
        plugin = power-theme;
        extraConfig = ''
          set -g @tmux_power_theme 'violet'

          # Window styling
          set -g @tmux_power_theme_left_separator ""
          set -g @tmux_power_theme_right_separator ""

          # Make inactive windows cleaner
          set -g @tmux_power_theme_window_status_style "rounded"

          # Better module spacing
          set -g @tmux_power_theme_status_content_spacing "1"

          # Window numbers
          set -g @tmux_power_theme_window_number_position "left"

          # Git support
          set -g @tmux_power_theme_show_git "1"

          # Datetime
          set -g @tmux_power_theme_show_datetime "1"

          # Battery
          set -g @tmux_power_theme_show_battery "1"

          # CPU
          set -g @tmux_power_theme_show_cpu "1"
        '';
      }

      {
        plugin = extrakto;
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
}
