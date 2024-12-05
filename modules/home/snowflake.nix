{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.home.snowflake;
  generated = pkgs.callPackage ../../_sources/generated.nix { };
in {
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
      "org/gnome/shell" = {
        "favorite-apps" = ["firefox.desktop" "Alacritty.desktop" "org.gnome.Settings.desktop" ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        "close" = [ "<Super>q" ];
        "switch-to-workspace-1" = [ "<Super>1" ];
        "switch-to-workspace-2" = [ "<Super>2" ];
        "switch-to-workspace-3" = [ "<Super>3" ];
        "switch-to-workspace-4" = [ "<Super>4" ];
        "switch-to-workspace-5" = [ "<Super>5" ];
        "move-to-workspace-left" = [ "" ];
        "move-to-workspace-right" = [ "" ];
      };
    };
  };
}
