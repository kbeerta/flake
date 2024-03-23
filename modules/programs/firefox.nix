{ pkgs, user, ... }: let
  theme = import ../theme.nix;
in {
  home-manager.users.${user} = {
    home.file."cascade" = {
      recursive = true;
      target = ".mozilla/firefox/default/chrome/cascade";
      source = (fetchTarball {
        url = "https://github.com/cascadefox/cascade/archive/master.tar.gz";
        sha256 = "sha256:0k7g4aijc8gz1941a791qdbqfcc3wlwlvfn70nzxp14jssjd5i8q";
      });
    };

    programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # "svg.context-properties.content.enabled" = true;
          # "layers.acceleration.force-enabled" = true;
          # "gfx.webrender.all" = true;
        };
        userChrome = ''
          @import "cascade/chrome/userChrome.css";

          @media (prefers-color-scheme: dark) { :root {
            /*  Cascades main Colour Scheme */
            --uc-base-colour:               ${theme.bg0} !important;
            --uc-highlight-colour:          ${theme.bg1} !important;
            --uc-inverted-colour:           ${theme.fg0} !important;
            --uc-muted-colour:              ${theme.special_accent} !important;
            --uc-accent-colour:             ${theme.special} !important;
          }}
        '';
      };
    };
  };
}
