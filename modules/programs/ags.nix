{ inputs, config, lib, pkgs, user, ... }:
with lib; {
  config = mkIf (config.hyprland.enable) {
    services.upower = {
      enable = true;
      usePercentageForPolicy = true;

      percentageLow = 25;
      percentageCritical = 5;
    };

    home-manager.users.${user} = {
      imports = [
        inputs.ags.homeManagerModules.default
      ];

      programs.ags = {
        enable = true;
        extraPackages = [ pkgs.libsoup_3 ];
      };

      home.file.".config/ags" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "kbeerta";
          repo = "ags-config";
          rev = "eb9d5a8";
          sha256 = "sha256-51p2fLtEcPV1pNDzQaa7rk+LgWdWKhRCr1RBvT1+Uk8=";
        };
      };
    };
  };
}

