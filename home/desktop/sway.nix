{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
	home = {
    packages = with pkgs; [
      fzf
      autotiling
    ];
    sessionVariables = {
      FZF_DEFAULT_OPTS = ''
        --color=fg:-1,bg:-1,hl:magenta
        --color=fg+:-1,bg+:-1,hl+:magenta
        --color=info:magenta,prompt:magenta,pointer:magenta
        --color=marker:magenta,spinner:magenta,header:magenta
      '';
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    systemd.enable = true;

    package = inputs.swayfx.packages.${pkgs.system}.default;

    config = rec {
      modifier = "Mod1";

      menu = "${pkgs.alacritty}/bin/alacritty --class 'fzf-menu' -e bash -c 'compgen -c | sort -u | fzf | xargs ${inputs.swayfx.packages.${pkgs.system}.default}/bin/swaymsg exec --'";
      terminal = "${pkgs.alacritty}/bin/alacritty";

      bars = [ ];

      gaps = {
        inner = 10;
      };

      window = {
        border = 0;
        titlebar = false;
      };

      fonts = {
        names = [ "JetBrainsMono NF" ];
        size = 10.0;
      };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          repeat_rate = "25";
          repeat_delay = "250";
        };
      };

      output = {
        "*".bg = "~/flake/wallpapers/catppuccin.png fill";
        "*".scale = "1";
        "eDP-1" = {
          mode = "1920x1080";
          pos = "0 0";
        };
      };

      startup = [
        { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }
      ];

      keybindings = {
        "${modifier}+Shift+Escape" = "exec swaymsg exit";

        "${modifier}+q" = "exec swaymsg kill";
        "${modifier}+Shift+r" = "exec swaymsg reload";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Space" = "exec ${menu}";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";

        "${modifier}+Shift+1" = "move container to workspace 1";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5";

        "F11" = "fullscreen";

        "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 2%+";
        "XF86AudioLowerVolume"= "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 2%-";
        "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
      };
    };

    extraConfig = ''
      corner_radius 5

      for_window [app_id="Alacritty"] opacity 0.85

      for_window [app_id="fzf-menu"] opacity 0.85
      for_window [app_id="fzf-menu"] floating enable
    '';
  };
}
