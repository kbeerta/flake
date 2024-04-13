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
          echo "%F{10}@%f%F{6}$(current_branch)%f"
        fi
      }

      setopt prompt_subst

      export PROMPT='%F{9}[%f%F{11}%n%f$(git_expander) %F{13}%1~%f%F{9}]%f%(?.%f.%F{9})$%f '
    '';
  };
}
