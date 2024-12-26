{pkgs, ...}: let
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
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "xterm-256color";
    historyLimit = 10000;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = import ./tmux/plugins.nix { inherit pkgs tmux-sessionx tmux-floax; };
    extraConfig = builtins.readFile ./tmux/extraConfig.conf;
  };
}

