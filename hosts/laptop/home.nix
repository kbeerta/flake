{ pkgs, ... }:
{
  imports = [
    ../../modules/desktop/river/home.nix
  ];

  home.packages = with pkgs; [

  ];

  programs = {
    alacritty.settings.font.size = 11;
  };
}
