({pkgs, ...}: {
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [zsh bash xsel lazygit obsidian];
    # loginShell = pkgs.zsh;
    systemPackages = with pkgs; [coreutils vim tmux qbittorrent jdk17 nodejs_20 go];
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
    
  fonts.packages = [pkgs.nerd-fonts.meslo-lg];
  # backwards compat; don't change
  system.stateVersion = 5;
  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = false;
    masApps = {};
    casks = [
      "raycast"
      "monitorcontrol"
      "ghostty"
      "1password@nightly"
      "slack"
      "obsidian"
      "dbeaver-community"
      "arc"
      "stremio"
      "whatsapp"
      "vlc"
      "brave-browser"
      "chromium"
      "karabiner-elements"  # Keyboard customization
      "rectangle"    # Window management
      "docker"
      "wezterm"     # Terminal emulator
    ];
    taps = [
      "fujiapple852/trippy"
      "atlassian/tap"
      "homebrew/bundle"
    ];
    brews = [
      "fujiapple852/trippy/trippy"  # Using full formula name to avoid conflicts
      "gh"
      "python@3.10"
      "python@3.11"
      "pnpm"
      "mysql"
      "redis"
      "rust"
      "neovim"
      "tree"
      "atlassian/tap/atlassian-plugin-sdk"
      "fswatch"
      "pipenv"
    ];
  };
})
