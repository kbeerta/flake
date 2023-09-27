{ pkgs, ... }:
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
  ];

  home.packages = with pkgs; [
    firefox
    discord
    libreoffice
  ];
}
