{ config, lib, pkgs, var, ...}:
let 
  colors = import ../colors.nix;
in
with lib;
{
  config = mkIf (config.wayland.enable) {
    home-manager.users.${var.user} = {
      home.packages = with pkgs; [
        bemenu
      ]; 

      # home.file.".config/tofi/config".text = ''
      #   font = "JetBrainsMono Nerd Font Medium"
      #   font-size = 12
      #
      #   default-result-background = ${colors.primary}
      #
      #   placeholder-background = ${colors.primary}
      #   placeholder-color = ${colors.text}
      #
      #   prompt-background = ${colors.primary}
      #   input-background = ${colors.primary}
      #
      #   selection-color = ${colors.secondary}
      #
      #   background-color = ${colors.primary}
      #   outline-width = 0
      #   border-width = 0
      #   corner-radius = 5
      #
      #   width = 640
      #   height = 360
      # '';
    };
  };
}
