{ pkgs, ... }:
{
  imports = [
    ../../modules/desktop/sway/home.nix
  ];

  home.packages = with pkgs; [
    firefox
    discord
    libreoffice
  ];
}
