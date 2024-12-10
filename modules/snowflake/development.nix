{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.system.snowflake.development;
in
{
  options.system.snowflake.development = {
    enable = mkEnableOption "development packages";

    c = {
      enable = mkEnableOption "c programming language";
    };
    lua = {
      enable = mkEnableOption "lua programming language";
    };
    zig = {
      enable = mkEnableOption "zig programming language";
    };
    rust = {
      enable = mkEnableOption "rust programming language";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [ nixd ]
      ++ (optionals (cfg.c.enable) [
        gcc
        ccls
      ])
      ++ (optionals (cfg.lua.enable) [
        lua
        sumneko-lua-language-server
      ])
      ++ (optionals (cfg.zig.enable) [
        zig
        zls
      ])
      ++ (optionals (cfg.rust.enable) [ rustup ]);
  };
}
