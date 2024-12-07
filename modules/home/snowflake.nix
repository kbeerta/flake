{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.snowflake;
  generated = pkgs.callPackage ../../_sources/generated.nix { };
in
{
  imports = [
    ./gnome.nix
  ];

  options.home.snowflake = {
    enable = mkEnableOption "gnome";
    user = mkOption {
      type = types.str;
      default = "snowflake";
    };
  };

  config = mkIf cfg.enable {
    home.username = "kbeerta";
    home.homeDirectory = "/home/kbeerta";
    home.stateVersion = "25.05";

    home.file = {
      ".config/nvim" = {
        recursive = true;
        source = "${generated.neovim.src}";
      };
      ".config/alacritty/catppuccin-mocha.toml" = {
        source = "${generated.catppuccin_alacritty.src}/catppuccin-mocha.toml";
      };
      ".config/alacritty/alacritty.toml" = {
        text = ''
          [general]
          import = [
            "~/.config/alacritty/catppuccin-mocha.toml"
          ]

          [font]
          size = 10

          [window]
          opacity = 0.90
          decorations = "None"
          startup_mode = "Maximized"
          padding = { x = 5, y = 5 }

          [font.normal]
          style = "Medium"
          family = "RobotoMono Nerd Font"
        '';
      };
    };

  };
}
