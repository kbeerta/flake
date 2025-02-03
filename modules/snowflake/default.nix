{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

with lib;
let
  cfg = config.system.snowflake;
in
{
  imports = [
    ./gnome.nix
    ./docker.nix
  ];

  options.system.snowflake = {
    enable = mkEnableOption "snowflake system";
    user = mkOption {
      type = types.str;
      default = "snowflake";
    };
  };

  config = mkIf cfg.enable {
    boot.loader.timeout = 2;
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "snowflake";
    networking.networkmanager.enable = true;

    users.users.${cfg.user} = {
      shell = pkgs.zsh;
      isNormalUser = true;
      initialPassword = "snowflake";
      extraGroups = [
        "audio"
        "input"
        "networkmanager"
        "video"
        "wheel"
      ];
    };

    fonts.packages = with pkgs; [
      nerd-fonts.roboto-mono
    ];

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      fzf
      nvfetcher
      pure-prompt

      nixd

      vimPlugins.nvim-treesitter.withAllGrammars
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        PURE_PROMPT_SYMBOL='$'
        autoload -U promptinit; promptinit
        prompt pure
      '';
    };

    programs.git.enable = true;
    programs.git.config.push.autoSetupRemote = true;

    programs.tmux.enable = true;

    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;
    programs.neovim.package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    nix.gc.dates = "weekly";
    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 7d";

    nix.channel.enable = false;
    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
