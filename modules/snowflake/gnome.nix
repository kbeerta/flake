{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.system.snowflake.gnome;
in {
  options.system.snowflake.gnome = {
    enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    security.rtkit.enable = true;

    services.pipewire.enable = true;
    services.pipewire.alsa.enable = true;
    services.pipewire.alsa.support32Bit= true;
    services.pipewire.pulse.enable = true;

    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard

      gnome-tweaks
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
      nautilus

      gnome-connections

      simple-scan
      totem
      yelp

      gnome-software
    ];
  };
}
