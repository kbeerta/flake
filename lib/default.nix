{ lib, pkgs, system, ... }:
rec {
  mkHost = { name, config, users }: let
    host_users = (map (u: mkUser u) users);
  in lib.nixosSystem {
      inherit system;

      modules = [
        {
          imports = [config] ++ host_users;

          nixpkgs.pkgs = pkgs;
          networking.hostName = "${name}";
          networking.networkmanager.enable = true;

          system.stateVersion = "24.11";
        }
      ];
    };
  mkUser = { name, groups, shell, packages }:
    {
      users.users."${name}" = {
        name = name;
        shell = shell;
        packages = packages;
        extraGroups = groups;
        isNormalUser = true;
        isSystemUser = false;
        initialPassword = "password";
      };
    };
}
