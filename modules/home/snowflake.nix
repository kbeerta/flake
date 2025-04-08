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
         spawn-at-startup "${pkgs.waybar}/bin/waybar"
         spawn-at-startup "${pkgs.wezterm}/bin/wezterm"
         spawn-at-startup "${pkgs.xwayland-satellite}/bin/xwayland-satellite"
         spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-m" "fill" "-i" "${../../wallpapers/wallhaven-jxmwvm.png}"

         prefer-no-csd
         screenshot-path null

         hotkey-overlay {
           skip-at-startup
         }

        layout {
           gaps 16
           focus-ring {
             off
           }
         }

         input {
           mod-key "Alt"
           focus-follows-mouse
           warp-mouse-to-focus
           keyboard {
             repeat-delay 250
             repeat-rate 25
           }
           mouse {
             natural-scroll
           }
           touchpad {
             tap
             natural-scroll
           }
         }

         cursor {
          hide-when-typing
         }

         binds {
           Mod+Shift+Escape { quit; }

           Mod+Space { spawn "fuzzel"; }
           Mod+Return { spawn "wezterm"; }

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

           XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
           XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }
           XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
         }

         window-rule {
           match app-id=r#"^org\.wezfurlong\.wezterm"#
           open-maximized true
         }

         window-rule {
           match app-id=r#"^org\.wezfurlong\.wezterm"# is-active=false
           opacity 0.5
         }
      '';
    };

    home.file.".config/waybar/style.css" = {
      text = ''
        * {
            border: none;
            min-height: 25px;
            padding: 0.125rem;
            font-size: 12px;
            font-weight: bold;
            font-family: "RobotoMono NF";
        }

        window#waybar {
            color: #e0def4;
            background: #191724;
        }

        #disk,
        #clock,
        #battery,
        #network,
        #pulseaudio {
            margin: 0 8px;
        }

        #battery.warning {
            color: #f6c177;
        }

        #battery.urgent,
        #battery.critical,
        #network.disconnected {
            color: #eb6d92;
        }
      '';
    };

    home.file.".config/waybar/config.jsonc" = {
      text = ''
        {
            "layer": "top",
            "modules-left": ["clock"],
            "modules-center": [],
            "modules-right": ["disk", "pulseaudio", "battery", "network"],

            "battery": {
                "format": "<span color=\"#6e6a86\">BAT</span> {capacity}%",
                "format-charging": "<span color=\"#f6c177\">BAT</span> {capacity}%"
            },

            "clock": {
                "format": "{:%H:%M}"
            },

            "disk": {
                "path": "/",
                "format": "<span color=\"#6e6a86\">/</span> {percentage_free}%"
            },

            "network": {
                "format-wifi": "",
                "format-disconnected": "DISCONNECTED"
            },

            "pulseaudio": {
                "format": "<span color=\"#6e6a86\">VOL</span> {volume}%",
                "format-muted": "<span color=\"#6e6a86\">VOL</span> -1%"
            }
        }
      '';
    };

    home.file.".config/fuzzel/fuzzel.ini" = {
      text = ''
        dpi-aware=no
        width=64
        font=RobotoMono Nerd Font Md:size=12
        fields=name,generic,comment,categories,filename,keywords
        terminal=wezterm
        exit-on-keyboard-focus-loss=no
        prompt="$ "

        [colors]
        foreground=e0def4ff
        background=232136ff
        selection=c4a7e7ff

        [border]
        radius=0

        [dmenu]
        exit-immediately-if-empty=yes
      '';
    };

    home.file.".config/wezterm/wezterm.lua" = {
      text = ''
        local wezterm = require("wezterm")
        local config = wezterm.config_builder()

        config.font = wezterm.font("RobotoMono Nerd Font Md")
        config.font_size = 10

        config.color_scheme = "rose-pine-moon"
        config.hide_tab_bar_if_only_one_tab = true

        return config
      '';
    };

    home.file.".config/ghostty/config" = {
      text = ''
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
        maximize = [ ];
        minimize = [ ];
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
