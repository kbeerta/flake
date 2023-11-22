{ config, lib, pkgs, inputs, user, ... }:
let 
  mod = "ALT";
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
    wayland.enable = true;     

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
      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;

        systemd.enable = true;
        xwayland.enable = true;

        settings = {
          monitor = [
              "eDP-1, 1920x0180@60.002998, 0x0, 1"
            ", highres, auto, auto"
          ];
          general = {
            gaps_in = 10;
            gaps_out = 10;
            border_size = 0;
            layout = dwindle;
          };
          input = {
            kb_layout = "us";
            touchpad = {
              natural_scroll = true;
              tap-to-click=true;
              middle_button_emulation=true;
            };
          };
          decoration = {
            rounding = 0;
            blur = {
              enabled = true;
              size = 3;
            };
            dim_inactive = true;
          };
          dwindle = {
            preserve_split = true;
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = 3;
            workspace_swipe_distance = 100;
          };
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            mouse_move_enables_dpms=true;
            key_press_enables_dpms=true;
          };
          exec-once = [
            "${pkgs.swayidle}/bin/swayidle -w timeout 60 '${pkgs.swaylock}/bin/swaylock -f' timeout 600 '${pkgs.systemd}/bin/systemctl suspend' after-resume '${config.programs.hyprland.package}/bin/hyprctl sipatch dpms on' before-sleep '${pkgs.swaylock}/bin/swaylock -f && ${config.programs.hyprland.package}/bin/hyprctl dispatch dpms off'"
            "${pkgs.eww-wayland}/bin/eww open bar"
          ];
          bind = [
            "${mod}, ESC, exit"
            "${mod}, Q, killactive"
            "${mod}, F, togglefullscreen"
            "${mod}, L, exec ${pkg.swaylock}/bin/swaylock"

            "${mod}, RETURN, exec, ${pkgs.alacritty}/bin/alacritty"
            "${mod}, SPACE, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"

            "${mod}, k, cyclenext"
            "${mod}, j, cycleprev"

            "${mod}, 1, workspace, 1"
            "${mod}, 2, workspace, 2"
            "${mod}, 3, workspace, 3"
            "${mod}, 4, workspace, 4"
            "${mod}, 5, workspace, 5"

            "${mod} SHIFT, 1, movetoworkspacesilent, 1"
            "${mod} SHIFT, 2, movetoworkspacesilent, 2"
            "${mod} SHIFT, 3, movetoworkspacesilent, 3"
            "${mod} SHIFT, 4, movetoworkspacesilent, 4"
            "${mod} SHIFT, 5, movetoworkspacesilent, 5"
          ];
          # bindings that repeat when held
          binde = [
            ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -u -i 5"
            ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -u -d 5"
            ", XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer"
            ", XF86AudioMicMute, exec, ${pkg.pamixer}/bin/pamixer --default-source -t"

            ", XF86BrightnessUp, exec, ${pkgs.light}/bin/light -A 5"
            ", XF86BrightnessDown, exec, ${pkgs.light}/bin/light -U 5"
          ];
        };
        extraConfig = ''
          preload = ~/flake/wallpapers/landscape.png
          wallpaper = eDP-1,~/flake/wallpapers/landscape.png
        '';
      };
    };
  };
}
