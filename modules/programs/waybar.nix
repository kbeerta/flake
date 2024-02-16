{ inputs, config, lib, pkgs, user, ... }:
let
  theme = import ../theme.nix;
in with lib; {
  config = mkIf (config.hyprland.enable) {
    environment.systemPackages = with pkgs; [
      waybar
    ];

    home-manager.users.${user} = {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar;
        systemd.enable = true;

        style = ''
          * {
            box-shadow: none;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-family: "JetBrainsMono Nerd Font";
            font-weight: bold;
          }

          window#waybar {
            background: ${theme.bg0};
            color: ${theme.fg0};
          }

          button:hover {
            color: ${theme.fg0};
            background: ${theme.bg1};
          }

          #window {
            color: ${theme.fg9};
            padding: 0 5px;
          }
        
          #workspaces button {
            color: ${theme.fg0};
            padding: 0 5px;
          }

          #workspaces button.active {
            color: ${theme.fg9};
          }

          #battery, #clock, #disk, #pulseaudio, #cpu, #memory {
            padding: 0 5px;
          }

          #clock {
            color: ${theme.fg9};
            padding-right: 15px;
            padding-left: 5px;
          }

          #custom-power {
            color: ${theme.red};
            padding-right: 5px;
            padding-left: 15px;
          }

          #custom-separator {
            color: ${theme.bg1};
            padding: 0 5px;
          }
        '';

        settings = {
          main = {
            layer = "top";
            position = "top";
            height = 30;

            margin-top = 10;
            # margin-bottom = 10;
            margin-left = 10;
            margin-right = 10;

            modules-left = [
              "custom/power"
              "custom/separator"
              "hyprland/workspaces"
              "custom/separator"
              "hyprland/window"
            ];
            modules-right = [
              "disk"
              "custom/separator"
              "memory"
              "custom/separator"
              "cpu"
              "custom/separator"
              "pulseaudio"
              "custom/separator"
              "battery"
              "custom/separator"
              "clock"
            ];

            "hyprland/workspaces" = {
              format = "{icon}";
              on-click = "activate";
              tooltip = false;
            };

            "hyprland/window" = {
              format = "{title}";
              max-length = 25;
            };

            clock = {
              format = "{:%R}";
              tooltip = false;
            };

            battery = {
              format = "<span color='${theme.fg8}'>BAT</span> {capacity}%";
              format-charging = "<span color='${theme.fg8}'>BAT</span> 󱦲{capacity}%";
              format-critical = "<span color='${theme.fg8}'>BAT</span> !{capacity}";
              states = {
                critical = 20;
              };
              tooltip = false;
            };

            cpu = {
              format = "<span color='${theme.fg8}'>CPU</span> {usage}%";
              interval = 5;
              tooltip = false;
            };

            memory = {
              format = "<span color='${theme.fg8}'>MEM</span> {percentage}%";
              interval = 5;
              tooltip = false;
            };

            pulseaudio = {
              format = "<span color='${theme.fg8}'>VOL</span> {volume}%";
              format-muted = "<span color='${theme.fg8}'>VOL</span> MUTED";
              tooltip = false;
            };

            disk = {
              format = "<span color='${theme.fg8}'>/</span> {percentage_used}%";
              path = "/";
            };

            "custom/power" = {
              format = "";
              on-click = "shutdown now";
              tooltip = false;
            };

            "custom/separator" = {
              format = "|";
            };
          };
        };
      };
    };
  };
}
