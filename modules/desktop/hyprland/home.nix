{ config, lib, pkgs, ... }:
let 
  wallpaper = "~/.flake/wallpapers/dreamcore.jpg";
in {
  xdg.configFile."hypr/hyprland.conf".text = ''
    monitor = eDP-1,1920x1080@60,0x0,1

    general {
      border_size = 0
      gaps_in = 10
      gaps_out = 10
      layout = dwindle
    }

    decoration {
      rounding = 5
    }

    animations {
        enabled = false
    }

    input {
        # kb_options=caps:escape
        follow_mouse = 2
        repeat_delay = 250

        touchpad {
            natural_scroll = false
            middle_button_emulation = true
            tap-to-click = true
        }
    }

    gestures {
        workspace_swipe = true 
        workspace_swipe_fingers = 3 
        workspace_swipe_distance = 100
    }

    dwindle {
        pseudotile = false
        force_split = 2
    }

    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
    }

      bind=ALT,RETURN,exec,${pkgs.alacritty}/bin/alacritty
      # TODO: fix this binding (let me be able to kill tofi when it runs)
      bind=ALT,SPACE,exec,tofi-drun --drun-launch=true
      bind=ALT,Q,killactive
      bind=ALT,F,fullscreen

      bind=ALT,J,movefocus,d
      bind=ALT,K,movefocus,u

      bind=CONTROLALT,J,movewindow,d
      bind=CONTROLALT,K,movewindow,u
      bind=CONTROLALT,L,movewindow,r
      bind=CONTROLALT,H,movewindow,l

      bind=ALT,1,workspace,1
      bind=ALT,2,workspace,2
      bind=ALT,3,workspace,3
      bind=ALT,4,workspace,4
      bind=ALT,5,workspace,5

      bind=ALTSHIFT,1,movetoworkspace,1
      bind=ALTSHIFT,2,movetoworkspace,2
      bind=ALTSHIFT,3,movetoworkspace,3
      bind=ALTSHIFT,4,movetoworkspace,4
      bind=ALTSHIFT,5,movetoworkspace,5


      bind=ALTSHIFT,H,resizeactive,-20 0
      bind=ALTSHIFT,L,resizeactive,20 0
      bind=ALTSHIFT,K,resizeactive,0 -20
      bind=ALTSHIFT,J,resizeactive,0 20

      binde=,XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -u -d 2
      binde=,XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -u -i 2
      bind=,XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t
      bind=,XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t 

      bindl=,XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 5
      bindl=,XF86MonBrightnessUp,exec,${pkgs.light}/bin/light -A 5

      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = ${pkgs.wbg}/bin/wbg ${wallpaper}
      exec-once = ${pkgs.eww-wayland}/bin/eww open bar
  '';
}
