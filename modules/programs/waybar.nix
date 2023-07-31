#
# Bar
#
# Gets imported in Window Manager
#

{ config, lib, pkgs, user, ...}:
{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  home-manager.users.${user} = {                          
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "sway-session.target";                  
      };
      style = ''
        * {
	  border: none;
	  font-family: JetBrainsMono Nerd Font;
	  font-size: 12px;
	}

	button:hover {
	  background-color: rgba(31, 31, 31, 1);
	}

	window#waybar {
	  color: rgba(246, 244, 244, 1);
	  background-color: rgba(17, 17, 17, 1);
	  border-bottom: none;
	}

        #workspace,
	#clock,
	#pulseaudio,
	#network,
	#cpu,
	#memory,
	#backlight,
	#battery,
	#tray {
          color: rgba(246, 244, 244, 1);
	  background-clip: padding-box;
	}

	#workspaces button {
	  padding: 5px 5px;
	}

	#workspaces button:hover {
	  background-color: rgba(31, 31, 31, 1);
	  color: rgba(246, 244, 244, 1);
	}

	#workspaces button.active {
	  background-color: rgba(31, 31, 31, 1);
	  color: rgba(246, 244, 244, 1);
	}

	#workspaces button.visible {
	  color: rgba(246, 244, 244, 1);
	}
      '';
      settings.Main = {
        layer = "top";
	position = "top";
	height = 32;
	modules-left = [ "sway/workspaces" "sway/window" ];
	modules-center = [ "clock" ];
	modules-right = [ "custom/performance-indicator" "custom/pad2" "cpu" "custom/pad2" "memory" "custom/pad" "backlight" "custom/pad2" "pulseaudio" "custom/pad" "network" "custom/pad2" "battery" "custom/pad" "tray" ];

	"custom/pad" = {
	  format = "     ";
	  tooltip = false;
	};

	"custom/pad2" = {
	  format = " ";
	  tooltip = false;
	};

	"custom/performance-indicator" = {
          format = " ";
	  tooltip = false;
	};

	"sway/workspaces" = {
	  all-outputs = true;
	  persistent_workspaces = {
	    "1" = [];
	    "2" = [];
	    "3" = [];
	    "4" = [];
	    "5" = [];
	  };
	};

	tray = {
	  spacing = 10;
	};

	clock = {
          format = "{:%H:%M}";
	  tooltip-format = "<big>{%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	};

	cpu = {
          format = "{}%  ";
	  interval = 1;
	  tooltip = false;
	};
	memory = {
          format = "{}%  ";
	  interval = 1;
	};
	backlight = {
	  device = "intel_backlight";
	  format = "{percent}% {icon} ";
	  format-icons = ["" ""];
	  tooltip = false;
	};
	pulseaudio = {
	  format = "{volume}% {icon} ";
	  format-muted = "x";
	  format-icons = {
	    default = [ "" "" "" ];
	  };
	  on-click = "${pkgs.pamixer}/bin/pamixer -t";
	  tooltip = false;
	};
	battery = {
	  format = "{capacity}% {icon} ";
	  format-charging = "{capacity}%  ";
          format-icons = ["" "" "" "" ""];
	  interval = 60;
	  states = {
	    warning = 30;
	    critical = 15;
	  };
	  max-length = 25;
	  tooltip = false;
	};
	network = {
	  format-wifi = "{essid}  ";
	  format-ethernet = "{ipaddr}  ";
	  format-disconnected = "No Connection";
	  tooltip = false;
	};
      };
    };
  };
}
