{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
  programs.nixvim = {
    enable = true;
		defaultEditor = true;

		globals = {
			mapleader = " ";
			loaded_perl_provider = 0;
			loaded_python_provider = 0;
			loaded_ruby_provider = 0;
		};

		opts = {
      laststatus = 4;
      statusline = "%{repeat('─',winwidth('.'))}";
			updatetime = 100;
			timeoutlen = 300;

			cursorline = true;

			tabstop = 4;
			shiftwidth = 4;
			softtabstop = 4;
			expandtab = true;
			autoindent = true;
			smartindent = true;

      mouse = null;
      number = true;
			relativenumber = true;

      wildmode = "longest:full,full";
			fileencoding = "utf-8";

			scrolloff = 8;
			sidescrolloff = 8;

			swapfile = false;
			undofile = true;
			
			termguicolors = true;
      clipboard = "unnamedplus";
		};

		keymaps = [
			{
				key = "<ESC>";
				mode = "n";
				action = "<cmd>noh<CR>";
			}
			{
				key = "<S-h>";
				mode = "n";
				action = "<cmd>bprev<CR>";
			}
			{
				key = "<S-l>";
				mode = "n";
				action = "<cmd>bnext<CR>";
			}
			{
				key = "-";
				mode = "n";
				action = "<cmd>Oil<CR>";
			}
			{
				key = "<leader>ff";
				mode = "n";
				action = "<cmd>FzfLua files<CR>";
			}
			{
				key = "<leader>fg";
				mode = "n";
				action = "<cmd>FzfLua grep<CR>";
			}
		];

		autoCmd = [
			{
			  event = "FileType";
				pattern = "nix";
				command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
			}
		];

		colorschemes.catppuccin = {
		  enable = true;
			flavour = "mocha";
			disableItalic = true;
			transparentBackground = true;
		};
		
		plugins = {
			lsp = {
				enable = true;
				keymaps.lspBuf = {
					"<leader>f" = "format";
				};

				servers = {
					ccls.enable = true;
					nixd.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
				};
			};

			cmp = {
				enable = true;
				autoEnableSources = true;

				settings = {
					mapping = {
						"<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
						"<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";

						"<CR>" = "cmp.mapping.confirm({ select = true })";
						"<C-Space" = "cmp.mapping.complete()";
					};

					sources = [
						{ name = "nvim_lsp"; }
						{ name = "luasnip"; }
						{ name = "buffer"; }
						{ name = "path"; }
					];

					snippet.expand = ''function (args)
							require("luasnip").lsp_expand(args.body)
						end
					'';
				};
			};

		  bufferline = {
        enable = true;
        showBufferIcons = false;
        showBufferCloseIcons = false;
      };

			treesitter = {
				enable = true;
				indent = true;
				nixvimInjections = true;
			};

      comment.enable = true;
      fzf-lua.enable = true;
			indent-blankline.enable = true;
      luasnip.enable = true;
			oil.enable = true;
		};
  };
}
