# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  neovim = {
    pname = "neovim";
    version = "7d481e26d1cdb5283da4384b905fa4007ad107a3";
    src = fetchFromGitHub {
      owner = "kbeerta";
      repo = "kbeerta.nvim";
      rev = "7d481e26d1cdb5283da4384b905fa4007ad107a3";
      fetchSubmodules = false;
      sha256 = "sha256-YU5IKZnfT3wID+yEPoMGVkigmj+IQqfZCxVttUsStnw=";
    };
    date = "2025-03-24";
  };
}
