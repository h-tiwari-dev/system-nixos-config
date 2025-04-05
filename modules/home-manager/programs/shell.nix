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

        eval "$(zoxide init --cmd cd zsh)"
      '';
      shellAliases = {
        ls = "ls --color=auto -F";
        nixswitch = "darwin-rebuild switch --flake ~/system-nixos/.#";
        nixup = "pushd ~/system-nixos; nix flake update; nixswitch; popd";
        lg = "lazygit";
        vim = "nvim";
        y = "yazi";
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
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.file.".inputrc".source = ../dotfiles/inputrc;
}
