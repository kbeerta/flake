{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware.nix ];

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.timeout = 2;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;

  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.jack.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.wireplumber.enable = true;

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  users.defaultUserShell = pkgs.zsh;

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;

  programs.sway.enable = true;
  programs.sway.package = pkgs.swayfx;
  programs.sway.xwayland.enable = true;
  programs.sway.extraPackages = with pkgs; [swaybg wl-clipboard brightnessctl];

  programs.waybar.enable = true;

  environment.loginShellInit = "[ \"$(tty)\" = \"/dev/tty1\" ] && exec ${pkgs.dbus}/bin/dbus-run-session ${pkgs.swayfx}/bin/sway";
}
