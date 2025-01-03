{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.snowflake;
  generated = pkgs.callPackage ../../_sources/generated.nix { };
in
{
  imports = [
    ./gnome.nix
  ];

  options.home.snowflake = {
    enable = mkEnableOption "gnome";
    user = mkOption {
      type = types.str;
      default = "snowflake";
    };
  };

  config = mkIf cfg.enable {
    home.username = "kbeerta";
    home.homeDirectory = "/home/kbeerta";
    home.stateVersion = "25.05";

    home.file.".config/nvim" = {
      recursive = true;
      source = "${generated.neovim.src}";
    };
    home.file.".config/ghostty/config" = {
      text = ''
        theme = catppuccin-mocha
        background-opacity = 0.9

        font-size = 10
        font-feature = -calt -liga -dlag
        font-family = "RobotoMono Nerd Font Md"

        cursor-style-blink = false

        resize-overlay = never
        window-decoration = false
        confirm-close-surface = false
      '';
    };
    home.file.".tmux.conf" = {
      text = ''
        set -s escape-time 0

        set -g mouse on
        set -g base-index 1
        set -g default-terminal "tmux-256color"

        unbind-key C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        bind-key x kill-pane
        bind-key & kill-window

        setw -g mode-keys vi

        set -g status on
        set -g status-interval 1
        set -g status-justify left
        set -g status-position bottom

        set -g status-keys vi
        set -g status-style fg=default

        set -g status-left ""
        set -g status-right ""

        set -g window-status-style fg=default
        set -g window-status-format ' #I #W '

        set -g window-status-current-style 'bg=magenta fg=black'
        set -g window-status-current-format ' #I #W '

        set -g visual-bell off
        set -g bell-action none
        set -g visual-silence off
        set -g visual-activity off

        setw -g monitor-activity off
      '';
    };
  };
}
