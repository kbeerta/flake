{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
  imports = import ./programs 
    ++ import ./shell;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
