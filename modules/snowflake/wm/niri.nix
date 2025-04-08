{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

with lib;
let
  cfg = config.system.snowflake.wm.niri;
in
{
  options.system.snowflake.wm.niri = {
    enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    system.snowflake.wayland.enable = true;

    programs.niri.enable = true;
    programs.niri.package = inputs.niri-nightly.packages.${pkgs.system}.default;

    programs.waybar.enable = true;

    xdg.portal.enable = true;

    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];

    # TODO systemd setup
    # TODO use niri-session instead of dbus-run-session
    environment.loginShellInit = ''
      if [[ -z $DISPLAY ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
          exec dbus-run-session ${inputs.niri-nightly.packages.${pkgs.system}.default}/bin/niri
      fi
    '';

    environment.systemPackages = with pkgs; [
      swaybg
      fuzzel
      xwayland-satellite
    ];
  };
}
