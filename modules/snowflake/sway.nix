{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.system.snowflake.sway;
in
{
  options.system.snowflake.sway = {
    enable = mkEnableOption "sway";
  };

  config = mkIf cfg.enable {
    system.snowflake.wayland.enable = true;

    environment.systemPackages = with pkgs; [
      swayfx
      swaybg
    ];
  };
}
