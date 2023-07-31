{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        sytax enable
        colorscheme srcery

        set number
        set relativenumber

	set tabstop=4
	set shiftwidth=4
	set expandtab
      '';
      packages.myVimPackages = with pkgs.vimPlugins; {
        start = [
          vim-nix
	  vim-markdown

	  auto-pairs
        ];
      };
    };
  };
}
