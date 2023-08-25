{ pkgs, ... }:
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
  ];

  home.packages = with pkgs; [

  ];

  programs = {
    alacritty.settings.font.size = 11;
  };
}
