{ config, lib, pkgs, inputs, user, ... }:
let 
  mod = "ALT";
  wallpaper = "~/flake/wallpapers/rice.png";
  theme = import ../colors.nix;
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

        fzf
      ];
    };

    hardware.opengl.enable = true;

    services.dbus.enable = true; 
    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
          user = "koenb";
        };
      };
      vt = 7;
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };

    home-manager.users.${user} = {
      xdg.configFile."hypr/hyprpaper.conf".text = ''
        preload = ${wallpaper}
        wallpaper = eDP-1,${wallpaper}
      '';
      xdg.configFile."hypr/hyprland.conf".text = ''
        monitor = eDP-1,1920x1080@60,0x0,1
        monitor = ,preferred,auto,1,mirror,eDP-1

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
          rounding = 5
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
        exec-once = ${pkgs.swayidle}/bin/swayidle -w timeout 600 '${pkgs.swaylock}/bin/swaylock --color ${theme.bg1} -d --daemonize' timeout 1200 '${pkgs.systemd}/bin/systemctl suspend' after-resume '${config.programs.hyprland.package}/bin/hyprctl sipatch dpms on' before-sleep '${pkgs.swaylock}/bin/swaylock --color ${theme.bg1} -d --daemonize && ${config.programs.hyprland.package}/bin/hyprctl dispatch dpms off'
        exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
        exec-once = ${pkgs.waybar}/bin/waybar

        bind = ${mod} SHIFT, ESCAPE, exit
        bind = ${mod}, Q, killactive
        bind = ${mod}, F, fullscreen
        bind = SUPER, L, exec, ${pkgs.swaylock}/bin/swaylock -d

        bind = ${mod}, RETURN, exec, ${pkgs.alacritty}/bin/alacritty
        bind = ${mod}, SPACE, exec, ${pkgs.alacritty}/bin/alacritty --title 'Alacritty fzf-menu' -e bash -c 'compgen -c | sort -u | fzf --no-color | xargs hyprctl dispatch exec --'

        bind = ${mod}, l, movefocus, r
        bind = ${mod}, h, movefocus, l
        bind = ${mod}, j, movefocus, d
        bind = ${mod}, k, movefocus, u

        binde = CONTROL ${mod}, l, resizeactive, 10 0 
        binde = CONTROL ${mod}, h, resizeactive, -10 0
        binde = CONTROL ${mod}, j, resizeactive, 0 10
        binde = CONTROL ${mod}, k, resizeactive, 0 -10

        bind = SHIFT ${mod}, l, swapwindow, r
        bind = SHIFT ${mod}, h, swapwindow, l
        bind = SHIFT ${mod}, j, swapwindow, d
        bind = SHIFT ${mod}, k, swapwindow, u


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

        bind = , Print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png

        bind = , XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t
        binde = , XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -u -i 5 
        binde = , XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -u -d 5 
        binde = , XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t

        binde = , XF86MonBrightnessUp, exec, ${pkgs.light}/bin/light -A 5 
        binde = , XF86MonBrightnessDown, exec, ${pkgs.light}/bin/light -U 5 

        windowrulev2 = float,title:(Alacritty fzf-menu)
        windowrulev2 = center 1, title:(Alacritty fzf-menu)
      '';
    };
  };
}
