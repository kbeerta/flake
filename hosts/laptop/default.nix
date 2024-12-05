{ outputs, ... }:

{
  imports = [
    ./hardware.nix
    outputs.nixosModules.snowflake
  ];

  system.snowflake = {
    enable = true;
    user = "kbeerta";

    dev.enable = true;
    gnome.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "us";
  console.font = "Lat2-Terminus16";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  system.stateVersion = "24.11";
}
