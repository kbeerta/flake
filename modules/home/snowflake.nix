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
          padding = { x = 5, y = 5 }

          [font.normal]
          style = "Medium"
          family = "RobotoMono Nerd Font"
        '';
      };
    };

    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        "button-layout" = "appmenu:minimize,maximize,close";
      };
      "org/gnome/desktop/interface" = {
        "icon-theme" = "Papirus-Dark";
        "color-scheme" = "prefer-dark";
        "show-battery-percentage" = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
        "close" = [ "<Super>q" ];
        "move-to-workspace-left" = [ "" ];
        "move-to-workspace-right" = [ "" ];
      };
    };
  };
}
