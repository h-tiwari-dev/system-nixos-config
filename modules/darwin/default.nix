({pkgs, ...}: {
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment = {
    shells = [pkgs.bash pkgs.zsh];
    loginShell = pkgs.zsh;
    systemPackages = [pkgs.coreutils];
    systemPath = ["/opt/homebrew/bin"];
    pathsToLink = ["/Applications"];
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
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {};
    casks = ["raycast" "monitorcontrol" "wezterm" "1password@nightly"];
    taps = ["fujiapple852/trippy"];
    brews = ["trippy" "gh"];
  };
})
