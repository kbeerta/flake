{ 
  pkgs,
  ... 
}: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";

    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    disableConfirmationPrompt = true;

    plugins = with pkgs; [
      tmuxPlugins.pain-control
    ];

    extraConfig = ''
      bind-key -T copy-mode-vi Escape send-keys -X cancel
      set -g status-bg magenta
      set -g status-fg black
    '';
  };
}
