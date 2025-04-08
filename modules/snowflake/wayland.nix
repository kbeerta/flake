{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.system.snowflake.wayland;
in
{
  options.system.snowflake.wayland = {
    enable = mkEnableOption "wayland";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    security.rtkit.enable = true;

    services.pipewire.enable = true;
    services.pipewire.alsa.enable = true;
    services.pipewire.alsa.support32Bit = true;
    services.pipewire.pulse.enable = true;

    environment.systemPackages = with pkgs; [
      # split the following into another file
      discord
      firefox
      wezterm
      wl-clipboard
    ];
  };
}
