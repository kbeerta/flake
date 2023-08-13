{ config, lib, pkgs, user, ... }:

{
  imports = (import ../modules/programs);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      firefox

      pamixer
      playerctl
    ];
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
