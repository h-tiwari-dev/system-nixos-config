({pkgs, ...}: {
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [bash zsh xsel lazygit obsidian];
    # loginShell = pkgs.zsh;
    systemPackages = with pkgs; [coreutils vim tmux qbittorrent jdk17 nodejs_20 go tmux];
    systemPath = ["/opt/homebrew/bin"];
    pathsToLink = ["/Applications"];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
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
      # finder.AppleShowAllExtensions = true;
      # finder._FXShowPosixPathInTitle = true;
      # dock.autohide = true;
      # NSGlobalDomain = {
      #   AppleShowAllExtensions = true;
      #   InitialKeyRepeat = 14;
      #   KeyRepeat = 1;
      # };
      PAM = {
        enableSudoTouchIdAuth = true;  # Enable Touch ID for sudo authentication
      };
      dock = {
        autohide = true;
        orientation = "bottom";
        tilesize = 48;
        show-recents = false;
        mineffect = "scale";
        minimize-to-application = true;
      };
      
      # Finder
      finder = {
        AppleShowAllFiles = true;
        _FXShowPosixPathInTitle = true;
        FXPreferredViewStyle = "Nlsv"; # List view
        ShowPathbar = true;
        ShowStatusBar = true;
        QuitMenuItem = true; # Allows quitting Finder
      };
      
      # Global macOS settings
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        ApplePressAndHoldEnabled = false; # For key repeat in VSCode and other editors
      };

      # Trackpad
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
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
      "vlc"
      "brave-browser"
      "docker"
      "chromium"
      "karabiner-elements"  # Keyboard customization
      "rectangle"    # Window management
    ];
    taps = [
      "fujiapple852/trippy"
      "atlassian/tap"
      "homebrew/services"
    ];
    brews = [
      "trippy"
      "gh"
      "python@3.10"
      "mysql"
      "redis"
      "rust"
      "neovim"
      "tree"
      "atlassian/tap/atlassian-plugin-sdk"
      "fswatch"
    ];
  };
})
