{ config, host, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    config = rec {
      modifier = "Mod1";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.wofi}/bin/wofi --show run | xargs swaymsg exec";
      
      startup = [
        { 
	  command = ''
            ${pkgs.swayidle}/bin/swayidle -w \
	      before-sleep '${pkgs.swaylock}/bin/swaylock'
	  ''; always = true;
	}
        { 
	  command = ''
            ${pkgs.swayidle}/bin/swayidle \
	      timeout 120 '${pkgs.swaylock}/bin/swaylock' \
	      timeout 240 'swaymsg "output * dpms off"' \
	      resume 'swaymsg "output * dpms on"' \
	      before-sleep '${pkgs.swaylock}/bin/swaylock'
	  ''; always = true;
	}
      ];


      bars = [];

      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
	size = 10.0;
      };

      gaps = {
        inner = 5;
      };

      window = {
        border = 2;
	titlebar = false;
      };

      input = {
        "type:touchpad" = {
	  tap = "enabled";
	  dwt = "enabled";
	  scroll_method = "two_finger";
	  natural_scroll = "enabled";
	};
	"type:keyboard" = {
          xkb_layout = "us";
	  xkb_numlock = "enabled";
	  xkb_options = "caps:escape";
	};
      };

      colors = {
        focused = {
          background = "#141415";
          border = "#434A4C";
          childBorder = "#434A4C";
	  indicator = "#141415";
          text = "#FFE9DD";
	};
        unfocused = {
          background = "#141415";
          border = "#262A2B";
          childBorder = "#262A2B";
	  indicator = "#141415";
          text = "#B9AAA2";
        };
      };

      keybindings = {
        "${modifier}+Escape" = "exec swaymsg exit";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Space" = "exec ${menu}";

        "${modifier}+r" = "reload";
        "${modifier}+q" = "kill";
        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+k" = "focus up";
        "${modifier}+j" = "focuse down";
        "${modifier}+h" = "focus left";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+l" = "move right";

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

	"XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
	"XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
	"XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
	"XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

	"XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 5";
	"XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";
      };
    };

    # TODO: Fix output bg thing
    extraConfig = ''
      output * bg ~/.flake/wallpapers/forest.jpg fill

      set $opacity 0.8
      for_window [app_id="Alacritty"] opacity $opacity
    '';
    extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=sway
      export XDG_CURRENT_DESKTOP=sway
    '';
  };
}
