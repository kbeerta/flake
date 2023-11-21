{ config, lib, pkgs, inputs, user, ... }:
with lib; {
  options = {
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.hyprland.enable) {
    wayland.enable = true;     

    environment = {
      loginShellInit = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec dbus-launch Hyprland
        fi 
      '';

      systemPackages = with pkgs; [
        grim
        slurp

        swayidle
        swaylock

        wl-clipboard
        wlr-randr
      ];
    };

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        };
      };
      vt = 7;
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    home-manager.users.${user} = {
      
    };
  };
}
