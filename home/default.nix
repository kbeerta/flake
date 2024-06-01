{ 
  inputs, 
  user,
  ... 
}: {
  imports = import ./desktop 
    ++ import ./programs 
    ++ import ./shell
    ++ [
      inputs.nixvim.homeManagerModules.nixvim
    ];

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
