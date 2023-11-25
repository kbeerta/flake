{ config, lib, pkgs, inputs, user, ... }:
let 
  mod = "ALT";
  wallpaper = "~/flake/wallpapers/rose.png";
in with lib; {
  options = {
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.hyprland.enable) {
    environment = {
      loginShellInit = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec dbus-launch Hyprland
        fi 
      '';

      variables = {
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
      };

      sessionVariables = {
        WLR_NO_HARDWARE_CURSOR = "1";
        NIXOS_OZONE_WL = "1";
      };

      systemPackages = with pkgs; [
        grim
        slurp

        hyprpaper
        swayidle
        swaylock

        wl-clipboard
        wlr-randr
        wev
      ];
    };

    hardware.opengl.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        };
      };
      vt = 7;
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };

    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    home-manager.users.${user} = {
      xdg.configFile."hypr/hyprpaper.conf".text = ''
        preload = ${wallpaper}
        wallpaper = eDP-1,${wallpaper}
      '';
      xdg.configFile."hypr/hyprland.conf".text = ''
        monitor = eDP-1,1920x1080@60,0x0,1

        general {
          gaps_out = 10
          border_size = 0
          col.active_border=0x00000000
          col.inactive_border=0x00000000
          layout = dwindle
        }

        input {
          repeat_rate = 25
          repeat_delay = 250
          touchpad {
            natural_scroll = true
            tap-to-click=true
            middle_button_emulation=true
          }
        }
          
        decoration {
          rounding = 0
          drop_shadow = false
          blur {
            enabled = true
            size = 3
          }
          dim_inactive = true
          dim_strength = 0.25
        }

        animations {
          enabled = false
        }
        
        dwindle {
          preserve_split = true
        }
        
        gestures {
          workspace_swipe = true
          workspace_swipe_fingers = 3
          workspace_swipe_distance = 100
        }

        misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
          mouse_move_enables_dpms = true
          key_press_enables_dpms = true
        }

        exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once = ${pkgs.swayidle}/bin/swayidle -w timeout 600 '${pkgs.swaylock}/bin/swaylock -d --daemonize' timeout 1200 '${pkgs.systemd}/bin/systemctl suspend' after-resume '${config.programs.hyprland.package}/bin/hyprctl sipatch dpms on' before-sleep '${pkgs.swaylock}/bin/swaylock -d --daemonize && ${config.programs.hyprland.package}/bin/hyprctl dispatch dpms off'
        exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
        exec-once = ${pkgs.eww-wayland}/bin/eww open bar

        bind = ${mod}, ESCAPE, exit
        bind = ${mod}, Q, killactive
        bind = ${mod}, F, fullscreen
        bind = ${mod}, L, exec, ${pkgs.swaylock}/bin/swaylock -d

        bind = ${mod}, RETURN, exec, ${pkgs.alacritty}/bin/alacritty
        bind = ${mod}, SPACE, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun

        bind = ${mod}, k, cyclenext
        bind = ${mod}, j, cyclenext, prev

        bind = ${mod}, 1, workspace, 1
        bind = ${mod}, 2, workspace, 2
        bind = ${mod}, 3, workspace, 3
        bind = ${mod}, 4, workspace, 4
        bind = ${mod}, 5, workspace, 5

        bind = ${mod} SHIFT, 1, movetoworkspacesilent, 1
        bind = ${mod} SHIFT, 2, movetoworkspacesilent, 2
        bind = ${mod} SHIFT, 3, movetoworkspacesilent, 3
        bind = ${mod} SHIFT, 4, movetoworkspacesilent, 4
        bind = ${mod} SHIFT, 5, movetoworkspacesilent, 5

        bind = , XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t
        binde = , XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -u -i 5
        binde = , XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -u -d 5
        binde = , XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t

        binde = , XF86BrightnessUp, exec, ${pkgs.light}/bin/light -A 5
        binde = , XF86BrightnessDown, exec, ${pkgs.light}/bin/light -U 5
      '';
    };
  };
}
