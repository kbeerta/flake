{ config, lib, pkgs, var, ... }:
let
  theme = import ../colors.nix;
in
with lib;
{
  options = {
    sway = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable sway within this flake
        '';
      };
    };
  };

  config = mkIf (config.sway.enable) {
    config.wayland.enable = true;

    environment = {
      loginShellInit = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec sway
        fi
     '';
    };

    programs = {
      sway = {
        enable = true;
        extraPackages = with pkgs; [
          autotiling

          swaylock-fancy

          wev
          wl-clipboard
          wlr-randr

          xwayland
        ];
      };
    };

    home-manager.users.${var.user} = {
      wayland.windowManager.sway = {
        enable = true;
        systemd.enable = true;
        config = rec {
          modifier = "Mod1";
          terminal = "${pkgs.${var.terminal}}/bin/${var.terminal}";
          # TODO: Change launcher 
          menu = "${pkgs.bemenu}/bin/bemenu-run -b";

          startup = [
            { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }
            { command = "${pkgs.eww-wayland}/bin/eww open bar"; always = true; }
          ];

          bars = [];

          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
            size = 10.0;
          };

          gaps = {
            inner = 10;
            # outer = 0;
          };

          window = {
            border = 0;
            titlebar = false;
          };

          input = {
            "type:touchpad" = {
              tap = "enabled";
              dwt = "enabled";
              scroll_method = "two_finger";
              middle_emulation = "enabled";
              natural_scroll = "enabled";
            };
            "type:keyboard" = {
              repeat_rate = "25";
              repeat_delay = "250";
              xkb_layout = "us";
              xkb_numlock = "enabled";
            };
          };

          output = {
            "*".bg = "${var.wallpaper} fill";
          };

          colors.focused = with theme; {
            background = "${primary}";
            border = "${primary-alt}";
            childBorder = "${primary-alt}";
            indicator = "${primary-alt}";
            text = "${text}";
          };

          keybindings = {
            "${modifier}+Escape" = "exec swaymsg exit";
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+Space" = "exec ${menu}";

            "${modifier}+l" = "exec ${pkgs.swaylock-fancy}/bin/swaylock-fancy";

            "${modifier}+r" = "reload";
            "${modifier}+q" = "kill";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+h" = "floating toggle";

            "${modifier}+k" = "focus next";
            "${modifier}+j" = "focus prev";

            "${modifier}+Shift+k" = "move up";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+l" = "move right";

            "${modifier}+Control+k" = "resize shrink height 20px";
            "${modifier}+Control+j" = "resize grow height 20px";
            "${modifier}+Control+h" = "resize shrink width 20px";
            "${modifier}+Control+l" = "resize grow width 20px";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";

            "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -u -d 5";
            "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -u -i 5";
            "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
            "XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

            "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 5";
            "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";
          };
        };
        extraConfig = ''
          set $opacity 0.85
          for_window [app_id="Alacritty"] opacity $opacity
        '';
        extraSessionCommands = ''
          # export BEMENU_BACKEND=wayland
          export XDG_SESSION_TYPE=wayland
          export XDG_SESSION_DESKTOP=sway
          export XDG_CURRENT_DESKTOP=sway
        '';
      };
    };
  };
}
