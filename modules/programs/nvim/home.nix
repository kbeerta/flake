{ pkgs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "kbeerta";
      repo = "nvim-config";
      rev = "75abc04";
      sha256 = "hGULu0mMzwdtz7xrTh7JMH59rQj926pTHNZixCsheTA=";
    };
  };
}
