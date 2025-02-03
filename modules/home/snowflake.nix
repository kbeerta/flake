{
  lib,
  pkgs,
  config,
  ...
}:

with lib;
with lib.hm.gvariant;

let
  cfg = config.system.snowflake.home;
  user = config.system.snowflake.home.user;
  generated = pkgs.callPackage ../../_sources/generated.nix { };
in
{
  options.system.snowflake.home = {
    enable = mkEnableOption "home";
    user = mkOption {
      type = types.str;
      default = "snowflake";
    };
  };

  config = mkIf cfg.enable {
    home.username = user;
    home.homeDirectory = "/home/${user}";
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

    dconf.settings = {
      "org/gnome/mutter" = {
        center-new-windows = true;
      };
      "org/gnome/shell" = {
        favourite-apps = [ ];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ ];
        toggle-tiled-right = [ ];
      };
      "org/gnome/desktop/interface" = {
        clock-format = "24h";
        clock-show-date = false;
        cursor-blink = false;
        enable-hot-corners = false;
        icon-theme = "Papirus-Dark";
        color-scheme = "prefer-dark";
        show-battery-percentage = true;
        monospace-font-name = "RobotoMono Nerd Font Md";
      };
      "org/gnome/desktop/peripherals/keyboard" = {
        delay = mkUint32 200;
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        maximize = [ ];
        unmaximize = [ ];
      };
      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "sloppy";
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "focus-changer@heartmire"
          "tiling-assistant@leleat-on-github"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/shell/extensions/focus-changer" = {
        focus-up = [ "<Shift><Super>k" ];
        focus-down = [ "<Shift><Super>j" ];
        focus-left = [ "<Shift><Super>h" ];
        focus-right = [ "<Shift><Super>l" ];
      };
    };
  };
}
