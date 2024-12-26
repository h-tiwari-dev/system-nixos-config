{pkgs, ...}: {
  imports = [
    ./programs/shell.nix
    ./programs/tmux.nix
    ./programs/terminal.nix
    ./programs/git.nix
    ./programs/core.nix
  ];

  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";

  # specify my home-manager configs
  home = {
    packages = with pkgs; [
      # Core utils
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

  # home.file.".inputrc".source = ./dotfiles/inputrc;
}
