{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    userName = "kbeerta";
    userEmail = "koenbeerta@gmail.com";
  };
}
