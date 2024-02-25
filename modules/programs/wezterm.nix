{ pkgs, user, ... }:
let
  theme = import ../theme.nix;
in {
  home-manager.users.${user} = {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        local wezterm = require 'wezterm'
        local config = {}

        config.colors = {
          foreground = ${theme.fg0},
          background = ${theme.bg0},

          cursor_bg = ${theme.fg0},
          cursor_fg = ${theme.bg0},
        }

        config.font = wezterm.font 'JetBrainsMono Nerd Font'

        return config
      '';
    };
  };
}
