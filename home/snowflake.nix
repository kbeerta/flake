{ outputs, ... }:

{
  imports = [
    outputs.homeManagerModules.snowflake
  ];

  home.snowflake = {
    enable = true;
    user = "kbeerta";
    gnome.enable = true;
  };
}
