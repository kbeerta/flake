{
  config,
  lib,
  ...
}:

with lib;
with lib.hm.gvariant;

let
  cfg = config.home.snowflake.gnome;
in
{
  options.home.snowflake.gnome = {
    enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {
    dconf.settings = {
      "org/gnome/mutter" = {
        center-new-windows = true;
      };
      "org/gnome/shell" = {
        favourite-apps = [ ];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ ];
        toggle-tiled-right = [ ];
      };
      "org/gnome/desktop/interface" = {
        clock-format = "24h";
        clock-show-date = false;
        cursor-blink = false;
        enable-hot-corners = false;
        icon-theme = "Papirus-Dark";
        color-scheme = "prefer-dark";
        show-battery-percentage = true;
        monospace-font-name = "RobotoMono Nerd Font Md";
      };
      "org/gnome/desktop/peripherals/keyboard" = {
        delay = mkUint32 200;
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        maximize = [ ];
        unmaximize = [ ];
      };
      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "sloppy";
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "focus-changer@heartmire"
          "tiling-assistant@leleat-on-github"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/shell/extensions/tiling-assistant" = {
        window-gap = 4;
        single-screen-gap = 4;
        maximize-with-gap = true;
      };
      "org/gnome/shell/extensions/focus-changer" = {
        focus-up = [ "<Shift><Super>k" ];
        focus-down = [ "<Shift><Super>j" ];
        focus-left = [ "<Shift><Super>h" ];
        focus-right = [ "<Shift><Super>l" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>return";
        command = "ghostty";
        name = "ghostty";
      };
    };
  };
}
