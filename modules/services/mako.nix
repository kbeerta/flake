{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    defaultTimeout = 4000;
  };
}
