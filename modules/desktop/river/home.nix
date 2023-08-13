{ config, host, lib, pkgs, ... }:
let 
  wallpaper = "~/.flake/wallpapers/sunset.jpg";
in {
  home.file.".config/river/init" = {
      executable = true;
      text = ''
            #!/bin/sh

            riverctl set-repeat 50 300

            riverctl spawn "${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --mode 1920x1080@60 --pos 0,0"
            riverctl spawn "${pkgs.eww-wayland}/bin/eww deamon"
            riverctl spawn "${pkgs.eww-wayland}/bin/eww open bar"
            riverctl spawn "${pkgs.swaybg}/bin/swaybg -i ${wallpaper} -m fill"

            riverctl map normal Super+Shift E exit

            riverctl map normal Super Return spawn "alacritty"
            riverctl map normal Super D spawn "wofi --show run"

            riverctl map normal Super Q close

            riverctl map normal Super J focus-view next
            riverctl map normal Super K focus-view previous

            riverctl map normal Super+Alt H move left 100
            riverctl map normal Super+Alt J move down 100
            riverctl map normal Super+Alt K move up 100
            riverctl map normal Super+Alt L move right 100

            riverctl map normal Super+Alt+Control H snap left 
            riverctl map normal Super+Alt+Control J snap down 
            riverctl map normal Super+Alt+Control K snap up 
            riverctl map normal Super+Alt+Control L snap right

            riverctl map normal Super+Alt+Shift H resize horizontal -100
            riverctl map normal Super+Alt+Shift J resize vertical 100
            riverctl map normal Super+Alt+Shift K resize vertical -100
            riverctl map normal Super+Alt+Shift L resize horizontal 100

            for i in $(seq 1 6) 
            do
                tags=$((1 << ($i - 1)))

                riverctl map normal Super $i spawn "riverctl set-focused-tags $tags & eww update current_workspace=$i"
                riverctl map normal Super+Shift $i set-view-tags $tags
                riverctl map normal Super+Control $i toggle-focused-tags $tags
                riverctl map normal Super+Shift+Control $i toggle-view-tags $tags

            done

            riverctl map normal Super Space toggle-float
            riverctl map normal Super F toggle-fullscreen

            riverctl map normal Super Up send-layout-cmd rivertile "main-location top"
            riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
            riverctl map normal Super Down send-layout-cmd rivertile "main-location bottom"
            riverctl map normal Super Left send-layout-cmd rivertile "main-location left"

            for mode in normal locked 
            do
                riverctl map $mode None XF86AudioRaiseVolume spawn 'pamixer -i 5'
                riverctl map $mode None XF86AudioLowerVolume spawn 'pamixer -d 5'
                riverctl map $mode None XF86AudioMute spawn 'pamixer --toggle-mute'

                riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
                riverctl map $mode None XF86AudioPlay spawn 'playerctl play-pause'
                riverctl map $mode None XF86AudioPrev spawn 'playerctl previous'
                riverctl map $mode None XF86AudioNext spawn 'playerctl next'

                riverctl map $mode None XF86MonBrightnessUp spawn 'light -A 5'
                riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5'

            done

            riverctl background-color 0x1F1F1F
            riverctl border-color-focused 0xF16A87
            riverctl border-color-unfocused 0xC9C2BD

            riverctl default-layout rivertile
            rivertile -view-padding 6 -outer-padding 6
        '';
    };
}
