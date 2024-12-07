{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.home.snowflake.gnome;
in
{
    options.home.snowflake.gnome = {
        enable = mkEnableOption "gnome";
    };

    config = mkIf cfg.enable {
        dconf.settings = {
            "org/gnome/desktop/wm/preferences" = {
                "button-layout" = "appmenu:minimize,maximize,close";
            };
            "org/gnome/desktop/interface" = {
                "icon-theme" = "Papirus-Dark";
                "color-scheme" = "prefer-dark";
                "show-battery-percentage" = true;
            };
            "org/gnome/desktop/wm/keybindings" = {
                "close" = [ "<Super>q" ];
                "switch-to-workspace-1" = [ "<Super>1" ];
                "switch-to-workspace-2" = [ "<Super>2" ];
                "switch-to-workspace-3" = [ "<Super>3" ];
                "switch-to-workspace-4" = [ "<Super>4" ];
                "switch-to-workspace-5" = [ "<Super>5" ];
            };
        };
    };
}
