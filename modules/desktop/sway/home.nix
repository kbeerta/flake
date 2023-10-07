{ config, lib, pkgs, ... }:
let 
  wallpaper = "~/.flake/wallpapers/landscape.png";
in {
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    config = rec {
      modifier = "Mod1";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      # TODO: fix this binding
      menu = "${pkgs.tofi}/bin/tofi-drun --drun-launch=true | xargs swaymsg exec";
      
      startup = [
      {
        command = ''${pkgs.eww-wayland}/bin/eww open bar'';
        always = true;
      }
      {
        command = ''${pkgs.sway}/bin/swaymsg output "*" bg ${wallpaper} fill'';
        always = true;
      }
      { 
        command = ''
          ${pkgs.swayidle}/bin/swayidle -w \
          before-sleep '${pkgs.swaylock}/bin/swaylock' --image ${wallpaper}
        ''; 
        always = true;
      }
      { 
        command = ''
          ${pkgs.swayidle}/bin/swayidle \
          timeout 120 '${pkgs.swaylock}/bin/swaylock' --image ${wallpaper} --no-unlock-indicator \
          timeout 240 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' \
          before-sleep '${pkgs.swaylock}/bin/swaylock' --image ${wallpaper} --no-unlock-indicator
          ''; 
        always = true;
      }
      ];


      bars = [];

      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
	      size = 10.0;
      };

      gaps = {
        inner = 10;
        # outer = 10;
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
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          repeat_rate = "25";
          repeat_delay = "250";
          xkb_layout = "us";
          xkb_numlock = "enabled";
          # xkb_options = "caps:escape";
        };
      };

      colors = {
        focused = {
          background = "#222222";
          border = "#222222";
          childBorder = "#222222";
	        indicator = "#222222";
          text = "#EEEEEE";
        };
        unfocused = {
          background = "#222222";
          border = "#222222";
          childBorder = "#222222";
	        indicator = "#222222";
          text = "#EEEEEE";
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

        "${modifier}+k" = "focus next";
        "${modifier}+j" = "focus prev";
        # "${modifier}+left" = "focus left";
        # "${modifier}+right" = "focus right";

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

        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -u -d 2";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -u -i 2";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
        "XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 2";
        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 2";
      };
    };
    extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=sway
      export XDG_CURRENT_DESKTOP=sway
    '';
  };
}
