
{ pkgs, user, ... }:
let
  theme = import ../theme.nix;
in {
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histSize = 100000;

    ohMyZsh = {
      enable = true;
      plugins = [ 
        "git" 
      ];
    };

    shellInit = ''
      SPACESHIP_CHAR_SYMBOL="${theme.icon} ";
      source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
      autoload -U promptinit; promptinit
    '';
  };
}
