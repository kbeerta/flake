{ pkgs, ... }:
{
  imports = [
    ../../modules/desktop/sway/home.nix
  ];

  home.packages = with pkgs; [

  ];

  programs = {
    alacritty.settings.font.size = 11;
  };
}
