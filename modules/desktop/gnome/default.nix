#
# Hyprland
#

{ config, lib, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  hardware.pulseaudio.enable = false;

  environment = {
    systemPackages = with pkgs; [                 # Packages installed
      gnome.dconf-editor
      gnome.gnome-tweaks
      # gnome.adwaita-icon-theme
    ];
    gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      # gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
  };
}
