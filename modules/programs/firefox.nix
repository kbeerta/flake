{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    home.file."cascade" = {
      recursive = true;
      target = ".mozilla/firefox/default/chrome/cascade";
      source = (fetchTarball {
        url = "https://github.com/andreasgrafen/cascade/archive/master.tar.gz";
        sha256 = "sha256:0z6b6krzlbpj3xvz8bmkqvxy0x84ff988ipx996ppvz78m4a3s64";
      });
    };

    programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        userChrome = ''
          @import "cascade/chrome/includes/cascade-colours.css";
          @import "cascade/chrome/includes/cascade-config-mouse.css";

          @import "cascade/chrome/includes/cascade-layout.css";
          @import "cascade/chrome/includes/cascade-responsive.css";
          @import "cascade/chrome/includes/cascade-floating-panel.css";

          @import "cascade/chrome/includes/cascade-nav-bar.css";
          @import "cascade/chrome/includes/cascade-tabs.css";
        '';
      };
    };
  };
}
