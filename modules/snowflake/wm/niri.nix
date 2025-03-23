{
  config,
  lib,
  pkgs,
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

    environment.systemPackages = with pkgs; [
      ags
      swaybg
      xwayland-satellite
    ];
  };
}
