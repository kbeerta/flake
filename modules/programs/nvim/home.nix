{ pkgs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "kbeerta";
      repo = "nvim-config";
      rev = "358dfac";
      sha256 = "alVTH4rSPn09545/P6a/jS0w15THA4h2UlBZT2V079w=";
    };
  };
}
