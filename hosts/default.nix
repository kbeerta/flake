{ 
  inputs,
  lib,
  pkgs,
  user,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "audio" "networkmanager" "wheel" "video" ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      autotiling

      wl-clipboard

      slurp
      grim

      alacritty

      fzf 
      pure-prompt

      dwarf-fortress
    ];
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec ${pkgs.swayfx-unwrapped}/bin/sway
      fi
    '';
    etc = {
      "nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
    };
  };

  programs = {
    firefox = {
      enable = true;
    };
    git = {
      enable = true;
    };
    light = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.neovim;
    };
    sway = {
      enable = true;
      package = pkgs.swayfx;
      xwayland.enable = true;
    };
    tmux = {
      enable = true;
    };
    waybar = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        autoload -U promptinit; promptinit 
        PURE_PROMPT_SYMBOL="$"
        zstyle :prompt:pure:path color magenta
        prompt pure
      '';
    };
  };

  services = {
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
  };


  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ 
        "JetBrainsMono" 
      ];
    })
  ];

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = false;
      experimental-features = [ "nix-command" "flakes" ];
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    };
  };

  system = {
    activationScripts.config = builtins.concatStringsSep "\n" (map (n: "ln -sfn ${../home}/${n} /home/${user}/.config/${n}") (builtins.attrNames (builtins.readDir ../home)));
    stateVersion = "24.11";
  };
}

