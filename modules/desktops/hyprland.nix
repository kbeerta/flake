{ config, lib, pkgs, inputs, user, ... }:
let 
  mod = "ALT";
  wallpaper = "~/flake/wallpapers/tank.png";
  theme = import ../theme.nix;
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

        FZF_DEFAULT_OPTS= ''
          --prompt='${theme.icon} '
          --color=fg:${theme.fg0},bg:${theme.bg0},hl:${theme.fg0}
          --color=fg+:${theme.fg0},bg+:${theme.bg1},hl+:${theme.green}
          --color=info:${theme.fg0},prompt:${theme.green},pointer:${theme.green}
          --color=marker:${theme.fg0},spinner:${theme.bg1},header:${theme.green}
        '';
      };

      systemPackages = with pkgs; [
        grim
        slurp

        hyprpaper
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

    home-manager.users.${user} = {
      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        systemd.enable = true;
        xwayland.enable = true;
        settings = {
          monitor = [
            "eDP-1,1920x1080@60,0x0,1"
            ",preferred,auto,1,mirror,eDP-1"
          ];

          general = {
            gaps_out = 10;
            border_size = 0;
            layout = "dwindle";
          };

          input = {
            repeat_rate = 25;
            repeat_delay = 250;
            touchpad = {
              natural_scroll = true;
              tap-to-click = true;
            };
          };

          decoration = {
            rounding = 5;
            drop_shadow = false;
            dim_inactive = true; 
            dim_strength = 0.25;
          };

          animations.enabled = false;
          dwindle.preserve_split = true;

          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = 3;
            workspace_swipe_distance = 100;
            workspace_swipe_numbered = true;
          };

          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;
          };

          exec-once = [
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "${pkgs.hyprpaper}/bin/hyprpaper"
          ];

          bind = [
            "${mod} SHIFT, ESCAPE, exit"
            "${mod}, Q, killactive"
            "${mod}, F, fullscreen"
            "SUPER, L, exec, ${pkgs.swaylock}/bin/swaylock"

            "${mod}, RETURN, exec, ${pkgs.alacritty}/bin/alacritty"
            "${mod}, SPACE, exec, ${pkgs.alacritty}/bin/alacritty --title 'Alacritty fzf-menu' -e bash -c 'compgen -c | sort -u | fzf | xargs hyprctl dispatch exec --'"

            "${mod}, l, movefocus, r"
            "${mod}, h, movefocus, l"
            "${mod}, j, movefocus, d"
            "${mod}, k, movefocus, u"

            "SHIFT ${mod}, l, swapwindow, r"
            "SHIFT ${mod}, h, swapwindow, l"
            "SHIFT ${mod}, j, swapwindow, d"
            "SHIFT ${mod}, k, swapwindow, u"

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

            ", Print, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png"
            ", XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t"
          ];
          binde = [
            "CONTROL ${mod}, l, resizeactive, 10 0 "
            "CONTROL ${mod}, h, resizeactive, -10 0"
            "CONTROL ${mod}, j, resizeactive, 0 10"
            "CONTROL ${mod}, k, resizeactive, 0 -10"

            ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -u -i 5 "
            ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -u -d 5 "
            ", XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t"

            ", XF86MonBrightnessUp, exec, ${pkgs.light}/bin/light -A 5 "
            ", XF86MonBrightnessDown, exec, ${pkgs.light}/bin/light -U 5 "
          ];

          windowrulev2 = [
            "opacity 0.95,class:^(Alacritty)$"
            "float,title:(Alacritty fzf-menu)"
            "center 1, title:(Alacritty fzf-menu)"
          ];
        };
      };
      xdg.configFile."hypr/hyprpaper.conf".text = ''
        preload = ${wallpaper}
        wallpaper = eDP-1,${wallpaper}
        ipc = off
      '';
    };
  };
}
