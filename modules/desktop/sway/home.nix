{ config, host, lib, pkgs, ... }:
let 
  wallpaper = "~/.flake/wallpapers/forest.jpg";
in {
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
	      before-sleep '${pkgs.swaylock}/bin/swaylock' --image ${wallpaper}
	  ''; always = true;
	}
        { 
	  command = ''
            ${pkgs.swayidle}/bin/swayidle \
	      timeout 120 '${pkgs.swaylock}/bin/swaylock' --image ${wallpaper} --no-unlock-indicator \
	      timeout 240 'swaymsg "output * dpms off"' \
	      resume 'swaymsg "output * dpms on"' \
	      before-sleep '${pkgs.swaylock}/bin/swaylock' --image ${wallpaper} --no-unlock-indicator
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
          border = "#D1E9C4";
          childBorder = "#D1E9C4";
	  indicator = "#141415";
          text = "#FFE9DD";
	};
        unfocused = {
          background = "#141415";
          border = "#111111";
          childBorder = "#111111";
	  indicator = "#141415";
          text = "#B9AAA2";
        };
      };

      keybindings = {
        "${modifier}+Escape" = "exec swaymsg exit";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Space" = "exec ${menu}";

	"${modifier}+l" = "exec ${pkgs.swaylock}/bin/swaylock --image ${wallpaper} --no-unlock-indicator";

        "${modifier}+r" = "reload";
        "${modifier}+q" = "kill";
        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+up" = "focus up";
        "${modifier}+down" = "focuse down";
        "${modifier}+left" = "focus left";
        "${modifier}+right" = "focus right";

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

    extraConfig = ''
      output * bg ${wallpaper} fill

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
