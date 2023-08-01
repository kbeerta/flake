#
# Nvim
#
# Gets imported in ~/hosts/configuration.nix
#

{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    configure = {
      extraConfig = ''
        syntax enable
        colorscheme habamax

	set number
	set relativenumber
	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
	set expandtab
	set smartindent

        set termguicolors

        nmap <Space-n> :Ex<CR>
      '';
    };
  };
}
