{ inputs, config, lib, pkgs, user, ... }:
with lib; {
  config = mkIf (config.hyprland.enable) {
    services.upower.enable = true;
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
          rev = "dc8662b";
          sha256 = "sha256-8nXL47Xrzli3Entp3R7m/aZrbkslF1LkEcq+7GGixbI=";
        };
      };
    };
  };
}

