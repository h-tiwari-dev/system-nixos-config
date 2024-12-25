{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ripgrep
      fd
      curl
      less
      jdk17
      google-chrome
    ];
    sessionVariables = {
      PAGER = "less";
      CLICLOLOR = 1;
      EDITOR = "nvim";
      OBJC_DISABLE_INITIALIZE_FORK_SAFETY = "YES";
      PATH = "$PATH:${pkgs.jdk17}/lib/openjdk:${pkgs.google-chrome}/bin";
    };
  };
}

