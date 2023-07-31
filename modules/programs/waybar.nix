#
# Bar
#
# Gets imported in Window Manager
#

{ config, lib, pkgs, host, user, ...}:
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
    };
  };
}
