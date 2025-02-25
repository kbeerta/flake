{ outputs, ... }:

{
  imports = [
    ./hardware.nix
    outputs.nixosModules.snowflake
  ];

  system.snowflake = {
    enable = true;
    user = "kbeerta";

    sway.enable = true;
    gnome.enable = true;
    docker.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "us";
  console.font = "Lat2-Terminus16";

  services.openssh.enable = true;
  services.openssh.settings.X11Forwarding = true;

  system.stateVersion = "24.11";
}
