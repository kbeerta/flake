{ pkgs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "kbeerta";
      repo = "nvim-config";
      rev = "0adad2e";
      sha256 = "A2UqrTWAJuUnn48sVYcurCemgIrloG5pGbTRY48gfzI=";
    };
  };
}
