{ pkgs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "kbeerta";
      repo = "nvim-config";
      rev = "358dfac";
      sha256 = "Vc3ZXf/R2OtGa7trfqdcEmfTx3CPSXhtWKltah21wSw=";
    };
  };
}
