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
