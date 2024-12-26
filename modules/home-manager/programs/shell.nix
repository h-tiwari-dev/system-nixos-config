{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        # Source environment variables from .env file
        if [ -f "$HOME/.env" ]; then
          set -a
          source "$HOME/.env"
          set +a
        fi

        # Auto-start tmux
        if [ -z "$TMUX" ]; then
          exec tmux new-session -A -s main
        fi
      '';
      shellAliases = {
        ls = "ls --color=auto -F";
        nixswitch = "darwin-rebuild switch --flake ~/src/system-config/.#";
        nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
        lg = "lazygit";
      };
    };
    
    starship.enable = true;
    starship.enableZshIntegration = true;
    
    bat.enable = true;
    bat.config.theme = "TwoDark";
    
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    
    eza.enable = true;
  };

  home.file.".inputrc".source = ../dotfiles/inputrc;
}

# /nix/store/1zlsvhkyck6j2vywiila4n8k3a2vh17f-hm_tmuxtmux.conf:62: ambiguous command: , could be: attach-session, bind-key, break-pane, capture-pane, choose-buffer, choose-client, choose-tree, clear-history, clear-prompt-history, clock-mode, command-prompt, confirm-before, copy-mode, customize-mode, delete-buffer, detach-client, display-menu, display-message, display-popup, display-panes, find-window, has-session, if-shell, join-pane, kill-pane, kill-server, kill-session, kill-window, last-pane, last-window, link-window, list-buffers, list-clients, list-commands, list-keys, list-panes, list-sessions, list-windows, load-buffer, lock-client, lock-server, lock-session, move-pane, move-window, new-session, new-window, next-layout, next-window, paste-buffer, pipe-pane, previous-layout, previous-window, refresh-client, rename-session, rename-window, resize-pane, resize-window, respawn-pane, respawn-window, rotate-window, run-shell, save-buffer, select-layout, select-pane, select-window, send-keys, send-prefix, server-access, set-buffer, set-environment, set-hook, set-option, set-window-option, show-buffer, show-environment, show-hooks, show-messages, show-options, show-prompt-history, show-window-options, source-file, split-window, start-server, suspend-client, swap-pane, swap-window, switch-client, unbind-key, unlink-window, wait-for


