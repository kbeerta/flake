{ pkgs, ... }:
{
  programs.git.enable = true;

  environment = {
    systemPackages = with pkgs; [
      lazygit
    ];
  };
}
