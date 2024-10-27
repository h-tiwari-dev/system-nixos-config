''
  # Set prefix to Ctrl-a
  unbind C-b
  set -g prefix C-a
  bind C-a send-prefix

  # Enable mouse support
  set -g mouse on

  # Start windows and panes at 1, not 0
  set -g base-index 1
  setw -g pane-base-index 1
  
  # Renumber windows when one is closed
  set -g renumber-windows on

  # Vi-style key bindings
  setw -g mode-keys vi
  bind-key -T copy-mode-vi 'v' send -X begin-selection
  bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

  # Split panes using | and -
  bind | split-window -h -c "#{pane_current_path}"
  bind - split-window -v -c "#{pane_current_path}"
  unbind '"'
  unbind %

  # Switch panes using Alt-arrow without prefix
  bind -n M-Left select-pane -L
  bind -n M-Right select-pane -R
  bind -n M-Up select-pane -U
  bind -n M-Down select-pane -D

  # Shift arrow to switch windows
  bind -n S-Left previous-window
  bind -n S-Right next-window

  # Reload config file
  bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

  # Pane resizing
  bind -r H resize-pane -L 5
  bind -r J resize-pane -D 5
  bind -r K resize-pane -U 5
  bind -r L resize-pane -R 5

  # Smart pane switching with awareness of Vim splits
  bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
  bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
  bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
  bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"

  # Status bar settings
  set -g status-position top
  set -g status-interval 1
  set -g status-justify left

  # Enable true color support
  set -ag terminal-overrides ",xterm-256color:RGB"
  set -g default-terminal "tmux-256color"

  # Set window notifications
  setw -g monitor-activity on
  set -g visual-activity off

  # Automatically set window title
  set-window-option -g automatic-rename on
  set-option -g set-titles on

  # Focus events enabled for terminals that support them
  set -g focus-events on

  # Increase scrollback buffer size
  set -g history-limit 50000

  # Display tmux messages for 4 seconds
  set -g display-time 4000

  # Refresh 'status-left' and 'status-right' more often
  set -g status-interval 5

  # Rather than constraining window size to the maximum size of any client 
  # connected to the *session*, constrain window size to the maximum size of any 
  # client connected to *that window*.
  setw -g aggressive-resize on

  # Don't detach when killing a session
  set-option -g detach-on-destroy off
''

