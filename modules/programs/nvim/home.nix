{ pkgs, ... }:
{
  xdg.configFile."nvim" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "kbeerta";
      repo = "nvim-config";
      rev = "6cfeb83";
      sha256 = "ctteORLTSTx4e5Hau5GEl6R+4Mwcwc9I5oEzNFgjjlY=";
    };
  };
}
