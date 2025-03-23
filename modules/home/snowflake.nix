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
    home.stateVersion = "25.05";
    home.homeDirectory = "/home/${user}";

    home.file.".config/nvim" = {
      recursive = true;
      source = "${generated.neovim.src}";
    };

    home.file.".config/niri/config.kdl" = {
      text = ''
        spawn-at-startup "${pkgs.ghostty}/bin/ghostty"
        spawn-at-startup "${pkgs.xwayland-satellite}/bin/xwayland-satellite"
        spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-m" "fill" "-i" "${../../wallpapers/wallhaven-jxmwvm.png}"

        prefer-no-csd
        screenshot-path null

        environment {
          DISPLAY ":0"
        }

        input {
          keyboard {
            repeat-delay 250
            repeat-rate 25
          }
        }

        binds {
          Mod+Shift+Escape { quit; }

          Mod+Return { spawn "ghostty"; }

          Mod+Q { close-window; }

          Mod+H { focus-column-left; }
          Mod+J { focus-workspace-down; }
          Mod+K { focus-workspace-up; }
          Mod+L { focus-column-right; }

          Mod+Shift+H { move-column-left; }
          Mod+Shift+J { move-column-to-workspace-down; }
          Mod+Shift+K { move-window-to-workspace-up; }
          Mod+Shift+L { move-column-right; }

          Mod+Ctrl+H { set-column-width "-10%"; }
          Mod+Ctrl+L { set-column-width "+10%"; }

          Mod+Up { maximize-column; }
        }

        window-rule {
          focus-ring {
            off
          }
        }

        window-rule {
          match is-active=false
          opacity 0.5
        }
      '';
    };

    home.file.".config/ghostty/config" = {
      text = ''
        maximize = true
        theme = rose-pine-moon

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
        set-option -g focus-events on

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
      "org/gnome/shell" = {
        favourite-apps = [ ];
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
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        maximize = [];
        minimize = [];
      };
      "org/gnome/desktop/peripherals/keyboard" = {
        delay = mkUint32 200;
      };
      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "sloppy";
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "pop-shell@system76.com"
          "just-perfection-desktop@just-perfection"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        ];
        disable-user-extensions = false;
      };
    };
  };
}
