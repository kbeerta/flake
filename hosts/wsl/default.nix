{ inputs, pkgs, var, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl.enable = true;
  wsl.defaultUser = var.user;
}

