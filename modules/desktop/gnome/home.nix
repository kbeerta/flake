{ config, lib, pkgs, ... }:
{
  dconf.settings = {
    "orgs/gnome/shell" = {
      disable-user-extension = false;
      enabled-extension = [
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      clock-show-weekday = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      maximize = ["<Alt>Plus"];
      unmaximize = ["<Alt>Minus"];
      # maximize = ["@as []"];
      # unmaximize = ["@as []"];
      switch-to-workspace-left = ["<Alt>Left"];
      switch-to-workspace-right = ["<Alt>Right"];
      switch-to-workspace-1 = ["<Alt>1"];
      switch-to-workspace-2 = ["<Alt>2"];
      switch-to-workspace-3 = ["<Alt>3"];
      switch-to-workspace-4 = ["<Alt>4"];
      switch-to-workspace-5 = ["<Alt>5"];
      move-to-workspace-left = ["<Shift><Alt>Left"];
      move-to-workspace-right = ["<Shift><Alt>Right"];
      move-to-workspace-1 = ["<Shift><Alt>1"];
      move-to-workspace-2 = ["<Shift><Alt>2"];
      move-to-workspace-3 = ["<Shift><Alt>3"];
      move-to-workspace-4 = ["<Shift><Alt>4"];
      move-to-workspace-5 = ["<Shift><Alt>5"];
      move-to-monitor-left = ["<Super><Alt>Left"];
      move-to-monitor-right = ["<Super><Alt>Right"];
      close = ["<Alt>q" "<Alt>F4"];
      toggle-fullscreen = ["<Super>f"];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>Return";
      command = "alacritty";
      name = "open-terminal";
    };
  };

  home.packages = with pkgs; [
  ];
}
