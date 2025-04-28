{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware.nix ];

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.timeout = 2;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  fonts.packages = with pkgs; [nerd-fonts.iosevka];
  environment.systemPackages = with pkgs; [neovim];

  programs.sway.enable = true;
  programs.sway.package = pkgs.sway;
  programs.sway.extraPackages = with pkgs; [swaybg swayidle swaylock wl-clipboard brightnessctl];
  programs.sway.xwayland.enable = true;

  programs.waybar.enable = true;

  environment.loginShellInit = "[ \"$(tty)\" = \"/dev/tty1\" ] && exec ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway";
}
