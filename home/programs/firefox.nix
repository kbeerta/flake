{ 
  pkgs,
  ... 
}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "default";
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        @import 'cascade/chrome/includes/cascade-config.css';
        @import 'cascade/chrome/includes/cascade-colours.css';

        @import 'cascade/chrome/includes/cascade-layout.css';
        @import 'cascade/chrome/includes/cascade-responsive.css';
        @import 'cascade/chrome/includes/cascade-floating-panel.css';

        @import 'cascade/chrome/includes/cascade-nav-bar.css';
        @import 'cascade/chrome/includes/cascade-tabs.css';

        :root {
          --uc-border-radius: 5px !important;
          --uc-urlbar-min-width: 0vw !important;
          --uc-urlbar-max-width: 100vw !important;
        }
      '';
    };
  };

  home.file."firefox/cascade" = {
    recursive = true;
    target = ".mozilla/firefox/default/chrome/cascade";
    source = (pkgs.fetchFromGitHub {
      owner = "cascadefox";
      repo = "cascade";
      rev = "8fbe98934fa58f934f7ed5253367396519b320a4";
      sha256 = "sha256-GMXSpNaShNu/Bce6TTnlgzGHV8MhHRVICv8hJqMi70w=";
    });
  };
}
