{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
  home.packages = with pkgs; [
    wbg
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        ",preferred,auto,1,mirror,eDP-1"
      ];

      general = {
        gaps_out = 10;
        border_size = 0;
        layout = "master";
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

      windowrulev2 = [
        "opacity 0.85, class:^(Alacritty)$"
      ];

      animations.enabled = false;

      master = {
        new_on_top = true;
        new_is_master = false;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 100;
        workspace_swipe_numbered = true;
      };

      exec-once = [
        "${pkgs.wbg}/bin/wbg ~/flake/wallpaper.png"
      ];

      bind = [
        "ALT SHIFT, ESCAPE, exit"
        "ALT, Q, killactive"

        "ALT, RETURN, exec, ${pkgs.alacritty}/bin/alacritty"

        "ALT, h, movefocus, l"
        "ALT, l, movefocus, r"
        "ALT, j, movefocus, d"
        "ALT, k, movefocus, u"

        "ALT SHIFT, h, swapwindow, l"
        "ALT SHIFT, l, swapwindow, r"
        "ALT SHIFT, j, swapwindow, d"
        "ALT SHIFT, k, swapwindow, u"

        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"

        "ALT SHIFT, 1, movetoworkspacesilent, 1"
        "ALT SHIFT, 2, movetoworkspacesilent, 2"
        "ALT SHIFT, 3, movetoworkspacesilent, 3"
        "ALT SHIFT, 4, movetoworkspacesilent, 4"
        "ALT SHIFT, 5, movetoworkspacesilent, 5"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 2%+"
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 2%-"
        ", XF86AudioMuteVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };
  };
}
