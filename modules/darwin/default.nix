({pkgs, ...}: {
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [bash zsh xsel lazygit obsidian];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [coreutils vim tmux];
    systemPath = ["/opt/homebrew/bin"];
    pathsToLink = ["/Applications"];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      MYSQL_USERNAME = "root";
      MYSQL_PASSWORD = "password";
      MYSQL_HOST = "localhost";
      ENVIRONMENT = "dev";
    };
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = true;
      dock.autohide = true;
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };
    };
  };
  fonts.packages = [(pkgs.nerdfonts.override {fonts = ["Meslo"];})];
  services.nix-daemon.enable = true;
  # backwards compat; don't change
  system.stateVersion = 4;
  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {};
    casks = [
      "raycast"
      "monitorcontrol"
      "wezterm"
      "1password@nightly"
      "slack"
      "obsidian"
      "dbeaver-community"
      "arc"
      "stremio"
      "whatsapp"
    ];
    taps = ["fujiapple852/trippy"];
    brews = [
      "trippy"
      "gh"
      "node"
      "python@3.10"
      "mysql"
      "redis"
    ];
  };
})
