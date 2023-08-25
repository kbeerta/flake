{ config, lib, pkgs, inputs, user, ... }:
{
  imports = 
    (import ../modules/shell) ++
    [(import ../modules/programs/nvim.nix)]
  ;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "video" "wheel" ];
    shell = pkgs.zsh;
  };

  time.timeZone = "Europe/Amsterdam";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MONETARY = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      fd
      neovim
      ripgrep
      wget
    ];
  };

  hardware.bluetooth.enable = true;

  services = {
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05"; # Did you read the comment?
}
