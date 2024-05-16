{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
  programs = {
    zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {
          arg0 = "fg=magenta";
        };
      };

      history = {
        size = 5000;
        share = true;

        ignoreDups = true;
        ignoreSpace = true;
      };

      initExtra = ''
        bindkey -e
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
      '';
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = "\n$directory$git_branch$git_status$line_break$character";

        directory = {
          style = "purple";
        };

        character = {
          success_symbol = "\[\\$\](yellow)";
          error_symbol = "\[\\$\](red)";
        };

        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };

        git_status = {
          format = "[$modified]($style)";
          style = "yellow";
          modified = "*";
        };

        command_timeout = 1000;
      };
    };
  };

}
