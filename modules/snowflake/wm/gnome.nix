{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.system.snowflake.wm.gnome;
in
{
  options.system.snowflake.wm.gnome = {
    enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {
    system.snowflake.wayland.enable = true;

    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      # split the following into another file
      discord
      firefox
      ghostty
      wl-clipboard

      matugen
      nodejs_latest

      gnome-tweaks
      gnome-shell-extensions

      gnomeExtensions.pop-shell
      gnomeExtensions.blur-my-shell
      gnomeExtensions.just-perfection

      dconf-editor
      papirus-icon-theme
    ];

    environment.gnome.excludePackages = with pkgs; [
      orca
      evince
      file-roller
      geary

      gnome-disk-utility

      seahorse
      sushi
      sysprof

      gnome-tour
      gnome-user-docs

      baobab
      epiphany

      gnome-text-editor
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-system-monitor
      gnome-weather

      loupe

      gnome-connections

      simple-scan
      totem
      yelp

      gnome-software
    ];
  };
}
