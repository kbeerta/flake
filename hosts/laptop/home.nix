{ pkgs, ... }:
{
  imports = [
    ../../modules/desktop/gnome/home.nix
  ];

  home.packages = with pkgs; [

  ];

  programs = {
    alacritty.settings.font.size = 11;
  };
}
