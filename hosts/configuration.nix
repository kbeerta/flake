{ config, lib, pkgs, inputs, var, ... }:
{
  imports = ( 
    import ../modules/desktops 
    ++ import ../modules/editors
    ++ import ../modules/hardware
    ++ import ../modules/programs
    ++ import ../modules/shell 
  );

  users.users.${var.user} = {
    isNormalUser = true;
    extraGroups = [ "audio" "camera" "networkmanager" "video" "wheel" ];
  };

  time.timeZone = "Europe/Amsterdam";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

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
      TERMINAL = "${var.terminal}";
      EDITOR = "${var.editor}";
      VISUAL = "${var.editor}";
    };
    systemPackages = with pkgs; [
      # Terminal
      fd
      git
      wget
      neovim
      ripgrep

      # Audio
      pamixer
      playerctl


      # Files
      unzip
      unrar
      zip
    ];
  };

  programs.dconf.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
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
        options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.05";

  home-manager.users.${var.user} = {
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
  };
}
