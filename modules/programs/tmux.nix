{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g status-bg "#D1E9C4"
    '';
  };
}
