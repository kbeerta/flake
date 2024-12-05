{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.system.snowflake.dev;
in {
  options.system.snowflake.dev = {
    enable = mkEnableOption "development packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      rustup
      nixd
      stylua
    ];
  };
}
