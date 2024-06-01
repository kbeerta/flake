{ 
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
        add_newline = true;
        format = ''$username$hostname$directory$git_branch$git_state$git_status$line_break$character'';

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
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "yellow";
          conflicted = "";
          untracked = "";
          modified = "";
          staged = "";
          renamed = "";
          deleted = "";
          stashed = "≡";
        };
      };
    };
  };
}
