{ outputs, config, pkgs, lib, ... }:

{
  imports = [
    outputs.homeManagerModules.snowflake
  ];

  home.snowflake = {
    enable = true;
    user = "kbeerta";
  };
}
