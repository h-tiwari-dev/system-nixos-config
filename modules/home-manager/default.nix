{
  pkgs,
  pwnvim,
  ...
}: let
  # Thanks: https://github.com/DanielFGray/dotfiles/blob/master/tmux.remote.conf
  remoteConf = builtins.toFile "tmux.remote.conf" ''
    unbind C-q
    unbind q
    set-option -g prefix C-s
    bind s send-prefix
    bind C-s last-window
    set-option -g status-position top
  '';
in {
  # Don't change this when you change package input. Leave it alone.
  home = {
    stateVersion = "22.11";

    # specify my home-manager configs
    packages = with pkgs; [
      ripgrep
      fd
      curl
      less
      pwnvim.packages."aarch64-darwin".default
    ];

    sessionVariables = {
      PAGER = "less";
      CLICLOLOR = 1;
      EDITOR = "nvim";
    };
  };
  programs = {
    bat.enable = true;
    bat.config.theme = "TwoDark";
    fzf.enable = true;
    fzf.enableZshIntegration = true;
    eza.enable = true;
    git.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "ls --color=auto -F";
        nixswitch = "darwin-rebuild switch --flake ~/src/system-config/.#";
        nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
        lg = "lazygit";
      };
    };
    starship.enable = true;
    starship.enableZshIntegration = true;
    alacritty = {
      enable = true;
      settings.font.normal.family = "MesloLGS Nerd Font Mono";
      settings.font.size = 16;
    };
    wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = builtins.readFile ../../dotfiles/wezterm/wezterm.lua;
    };
    lazygit = {
      enable = true;
    };
    tmux = {
      enable = true;
      shortcut = "q";
      escapeTime = 10;
      keyMode = "vi";
      terminal = "tmux-256color";
      historyLimit = 50000;

      extraConfig = with pkgs.tmuxPlugins; ''
        # Plugins
        run-shell '${copycat}/share/tmux-plugins/copycat/copycat.tmux'
        run-shell '${sensible}/share/tmux-plugins/sensible/sensible.tmux'
        run-shell '${urlview}/share/tmux-plugins/urlview/urlview.tmux'

        bind-key R run-shell ' \
          tmux source-file /etc/tmux.conf > /dev/null; \
          tmux display-message "sourced /etc/tmux.conf"'

        if -F "$SSH_CONNECTION" "source-file '${remoteConf}'"

        set-option -g status-right ' #{prefix_highlight} "#{=21:pane_title}" %H:%M %d-%b-%y'
        set-option -g status-left-length 20
        set-option -g @prefix_highlight_fg 'white'
        set-option -g @prefix_highlight_bg 'blue'
        run-shell '${prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux'

        # Be faster switching windows
        bind C-n next-window
        bind C-p previous-window

        # Send the bracketed paste mode when pasting
        bind ] paste-buffer -p

        set-option -g set-titles on

        bind C-y run-shell ' \
          ${pkgs.tmux}/bin/tmux show-buffer > /dev/null 2>&1 \
          && ${pkgs.tmux}/bin/tmux show-buffer | ${pkgs.xsel}/bin/xsel -ib'

        # Force true colors
        set-option -ga terminal-overrides ",*:Tc"

        set-option -g mouse on
        set-option -g focus-events on

        # Stay in same directory when split
        bind % split-window -h -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"

        # Colorscheme
        set-option -g status-style 'fg=white, bg=black'

        set-option -g window-status-current-style 'fg=yellow'

        set-option -g pane-border-style 'fg=black'
        set-option -g pane-active-border-style 'fg=green'

        set-option -g message-style 'fg=black, bg=yellow'

        set-option -g mode-style    'fg=black, bg=green'

        set-option -g display-panes-active-colour 'green'
        set-option -g display-panes-colour 'yellow'

        set-option -g clock-mode-colour 'green'
      '';
    };
  };

  home.file.".inputrc".source = ./dotfiles/inputrc;
}
