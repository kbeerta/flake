{ config, lib, pkgs, user, ... }:

{
  imports = (import ../modules/programs) ++ (import ../modules/services);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      firefox
      pamixer
    ];
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
