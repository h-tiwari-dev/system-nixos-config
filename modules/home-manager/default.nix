{pkgs,  ...}: let
tmux-sessionx = pkgs.tmuxPlugins.mkTmuxPlugin {
  pluginName = "sessionx";
  version = "unstable-2024-01-20";
  src = pkgs.fetchFromGitHub {
    owner = "omerxx";
    repo = "tmux-sessionx";
    rev = "ecc926e7db7761bfbd798cd8f10043e4fb1b83ba";
    sha256 = "1qa2a4m75w6k64f52fsw9k6yyiidlxm2q31w8hrsjd5bcdr6dzab";
  };
};
tmux-floax = pkgs.tmuxPlugins.mkTmuxPlugin {
  pluginName = "floax";
  version = "unstable-2024-02-20";
  src = pkgs.fetchFromGitHub {
    owner = "omerxx";
    repo = "tmux-floax";
    rev = "61c7f466b9a4ceed56f99d403250164170d586cd";
    sha256 = "DOwn7XEg/L95YieUAyZU0FJ49vm2xKGUclm8WCKDizU=";
  };
};
 in {
  imports = [
    ./programs/shell.nix
    ./programs/terminal.nix
    ./programs/git.nix
    ./programs/core.nix
  ];

  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";

  # specify my home-manager configs
  programs.zsh.enable = true;  # Ensure zsh is enabled at the top level

  home = {
    packages = with pkgs; [
      # Core utils
      yazi  # Modern file manager
      ripgrep
      fd
      curl
      less
      jdk17
      google-chrome
      # macOS specific
      m-cli          # useful macOS CLI commands
      mas            # Mac App Store CLI
      # darwin-zsh-completions
      # Development tools
      gh             # GitHub CLI
      jq             # JSON processor
      yq             # YAML processor
      tree          # Directory listing
      wget
      gnupg         # For signing commits and encryption
      # Archive tools
      unzip
      zip
      # System monitoring
      htop
      bottom        # System monitor
      # Network tools
      mtr           # Network diagnostic tool
      nmap          # Network exploration tool
      # Cloud tools
      awscli2       # If you use AWS
      terraform     # If you use Infrastructure as Code
    ];
    sessionVariables = {
      PAGER = "less";
      CLICLOLOR = 1;
      EDITOR = "nvim";
      OBJC_DISABLE_INITIALIZE_FORK_SAFETY = "YES";
      PATH = "$PATH:${pkgs.jdk17}/lib/openjdk:${pkgs.google-chrome}/bin";

      # macOS specific
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      # Development
      GITHUB_USER = "h-tiwari-kusho";
      # Java
      JAVA_HOME = "${pkgs.jdk17}";
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 50000;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      continuum
      {
        plugin = tmux-floax;
        extraConfig = ''
          # Main binding for floating pane toggle (prefix + p)
          set -g @floax-bind 'p'

          # Menu binding for additional options (prefix + P)
          set -g @floax-bind-menu 'P'

          # Floating pane size
          set -g @floax-width '80%'
          set -g @floax-height '80%'

          # Appearance
          set -g @floax-border-color 'magenta'
          set -g @floax-text-color 'blue'

          # Behavior
          set -g @floax-change-path 'true'
          set -g @floax-session-name 'float'
          set -g @floax-title '󱂬 floax'
        '';
      }
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          # Main binding and behavior
          set -g @sessionx-bind 'o'
          set -g @sessionx-prefix on
          set -g @sessionx-window-height '90%'
          set -g @sessionx-window-width '75%'

          # Preview settings
          set -g @sessionx-preview-enabled true
          set -g @sessionx-preview-location 'right'
          set -g @sessionx-preview-ratio '55%'

          # Display settings
          set -g @sessionx-prompt " "
          set -g @sessionx-pointer "▶ "
          set -g @sessionx-layout 'reverse'
          set -g @sessionx-tree-mode 'on'

          # Feature toggles
          set -g @sessionx-filter-current 'false'
          set -g @sessionx-window-mode 'on'
          set -g @sessionx-zoxide-mode 'on'

          # Custom paths and behavior
          set -g @sessionx-custom-paths '/Users/harshtiwari/Documents/AI-Youtube-Shorts-Generator,/Users/harshtiwari/Documents/obsidian,/Users/harshtiwari/Documents/resume,/Users/harshtiwari/Documents/wellnessliving/'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-x-path '$HOME/.config'

          # Key bindings
          set -g @sessionx-bind-kill-session 'alt-x'
          set -g @sessionx-bind-window-mode 'ctrl-w'
          set -g @sessionx-bind-tree-mode 'ctrl-t'
          set -g @sessionx-bind-configuration-path 'ctrl-x'
          set -g @sessionx-bind-back 'ctrl-b'
          set -g @sessionx-bind-rename-session 'ctrl-r'

          # FZF display settings
          set -g @sessionx-additional-options "--color pointer:9,spinner:92,marker:46"

          # Clear TMUX_PLUGIN_MANAGER_PATH to avoid conflicts
          set-environment -gu TMUX_PLUGIN_MANAGER_PATH
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules_right "directory date_time"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
    ];
    extraConfig = ''
      # Set prefix to Ctrl-s
      unbind C-b
      set -g prefix C-s
      bind C-s send-prefix

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

      # Ensure proper shell environment
      set -g default-command "${pkgs.zsh}/bin/zsh"
      set -g default-shell "${pkgs.zsh}/bin/zsh"
    '';
  };
  home.file.".inputrc".source = ./dotfiles/inputrc;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = false;
        sort_by = "modified";
        sort_reverse = true;
      };
      preview = {
        max_width = 2048;
        max_height = 2048;
      };
    };
  };
}
