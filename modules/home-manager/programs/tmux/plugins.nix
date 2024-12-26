{ pkgs, tmux-sessionx, tmux-floax }: 
with pkgs.tmuxPlugins; [
  sensible
  yank
  resurrect
  continuum
  {
    plugin = tmux-floax;
    extraConfig = builtins.readFile ./floax-config.conf;
  }
  {
    plugin = tmux-sessionx;
    extraConfig = builtins.readFile ./sessionx-config.conf;
  }
  {
    plugin = catppuccin;
    extraConfig = builtins.readFile ./catppuccin-config.conf;
  }
]

