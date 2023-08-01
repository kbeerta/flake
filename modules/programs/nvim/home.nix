{ pkgs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "slavjuan";
      repo = "nvim-config";
      rev = "eb93f81";
      sha256 = "A2UqrTWAJuUnn48sVYcurCemgIrloG5pGbTRY48gfzI=";
    };
  };
}
