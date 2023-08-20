{ pkgs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "kbeerta";
      repo = "nvim-config";
      rev = "decf0e5";
      sha256 = "HA8RjDtxzUyd8PvN07aGhGLIi3mvu3OpdAG1eg+EgG8=";
    };
  };
}
