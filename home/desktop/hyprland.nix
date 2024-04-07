{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

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

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      input = {
        repeat_rate = 25;
        repeat_delay = 250;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      bind = [
        "ALT SHIFT, ESCAPE, exit"
        "ALT, Q, killactive"

        "ALT, RETURN, exec, ${pkgs.alacritty}/bin/alacritty"

        "ALT, h, movefocus, l"
        "ALT, l, movefocus, r"
        "ALT, j, movefocus, d"
        "ALT, k, movefocus, u"

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
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };
  };
}
