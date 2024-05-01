{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    initExtra = ''
      git_expander() {
        if [[ ! -z "$(current_branch)" ]]; then
          echo "%F{14}@%f%F{12}$(current_branch)%f"
        fi
      }

      setopt prompt_subst

      export PROMPT='%F{9}[%f%F{13}%n%f$(git_expander) %F{11}%1~%f%F{9}]%f%(?.%f.%F{9})$%f '
    '';
  };
}
