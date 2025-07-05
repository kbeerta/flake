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

          environment.systemPackages = with pkgs; [git stow neovim nixd];

          nix.channel.enable = false;
          nix.settings.experimental-features = ["flakes" "nix-command"];

          system.stateVersion = "24.11";
        }
      ];
    };
  mkUser = { name, groups, fonts, packages }:
    {
      users.users."${name}" = {
        name = name;
        packages = packages;
        extraGroups = groups;
        isNormalUser = true;
        isSystemUser = false;
        useDefaultShell = true;
        initialPassword = "password";
      };

      fonts.packages = fonts;
    };
}
