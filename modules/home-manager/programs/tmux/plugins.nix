{ pkgs, tmux-sessionx, tmux-floax }: 
with pkgs.tmuxPlugins; [
  sensible
  yank
  resurrect
  continuum
  {
    plugin = tmux-floax;
    extraConfig = builtins.readFile ./floax-config.nix;
  }
  {
    plugin = tmux-sessionx;
    extraConfig = builtins.readFile ./sessionx-config.nix;
  }
  {
    plugin = catppuccin;
    extraConfig = builtins.readFile ./catppuccin-config.nix;
  }
]

