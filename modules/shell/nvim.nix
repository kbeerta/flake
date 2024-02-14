{ inputs, pkgs, ... }: {   
  environment.systemPackages = with pkgs; [
    fzf
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

		globals = {
			mapleader = " ";
			loaded_ruby_provider = 0;
			loaded_perl_provider = 0;
			loaded_python_provider = 0;
		};

		keymaps = [
		  # disable arrow keys
		  {
			  mode = [ "n" "x" "i" ];
			  key = "<Up>";
			  action = "<Nop>";
		  }
		  {
			  mode = [ "n" "x" "i" ];
			  key = "<Down>";
			  action = "<Nop>";
		  }
		  {
			  mode = [ "n" "x" "i" ];
			  key = "<Left>";
			  action = "<Nop>";
		  }
		  { 
        mode = [ "n" "x" "i" ];
			  key = "<Right>";
			  action = "<Nop>";
		  }

      # changing buffers
		  {
			  mode = "n";
			  key = "<S-l>";
			  action = "<cmd>bnext<CR>";
		  }
		  {
			  mode = "n";
			  key = "<S-h>";
			  action = "<cmd>bprev<CR>";
		  }
      # plugin keymaps
      {
        mode = "n";
        key = "-";
        action = "<cmd>Oil<CR>";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>FzfLua files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>FzfLua grep<CR>";
      }
      # {
      #   mode = "n";
      #   key = "<leader>ff";
      #   action = "<cmd>Telescope find_files<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<leader>fg";
      #   action = "<cmd>Telescope live_grep<CR>";
      # }
		];

		options = {
      laststatus = 4;
      statusline = "%{repeat('─',winwidth('.'))}";

			updatetime = 100;
      timeoutlen = 300;

			conceallevel = 3;
			cursorline = true;
			completeopt = [ "menu" "menuone" "noselect" ];

			mouse = null;
			number = true;
			relativenumber = true;

			autoindent = true;
			clipboard = "unnamedplus";
			expandtab = true;
			smartindent = true;

			tabstop = 4;
			shiftwidth = 4;
			softtabstop = 4;

			wildmode = "longest:full,full";
			fileencoding = "utf-8";

			scrolloff = 4;
			sidescrolloff = 8;

			guicursor = "i:hor10-Cursor/lCursor";
			termguicolors = true;

			swapfile = false;
			undofile = true;

			fillchars = {
				foldopen = "";
				foldclose = "";
				fold = "⸱";
				foldsep = " ";
				diff = "╱";
				eob = " ";
			};

			hlsearch = false;
		};

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

      transparentBackground = true;
      disableItalic = true;

      # Integrations will be handled by NixVim
      integrations = {
        native_lsp = {
          underlines = {
            errors = [ "undercurl" ];
            hints = [ "undercurl" ];
            warnings = [ "undercurl" ];
            information = [ "undercurl" ];
          };
        };
      };
    };

    plugins = {
      nvim-cmp = {
        enable = true;

        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
          "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-CR>" = ''cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          '';
          "<C-CR>" = ''function(fallback) 
              cmp.abort()
              fallback()
            end
          '';
        };

        snippet = {
          expand = "luasnip";
        };

        completion = {
          completeopt = "menu,menuone,noinsert";
        };

        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };

      lsp = {
        enable = true;

        keymaps.lspBuf = {
          "gd" = "definition";
          "gi" = "implementation";
          "gr" = "references";
          "gt" = "type_definition";

          "gD" = "declaration";
          "gK" = "signature_help";

          "K" = "hover";

          "<leader>f" = "format";
        };

        servers = {
          ccls.enable = true;
          # clangd.enable = true;
          emmet_ls.enable = true;
          eslint.enable = true;
          elixirls.enable = true;
          html.enable = true;
          lua-ls.enable = true;
          nixd.enable = true;
          omnisharp.enable = true;
          pyright.enable = true;
          # ruff-lsp.enable = true;
          rust-analyzer = {
            enable = true;

            # we install this when we use `flake.nix` in a cargo folder
            installCargo = false;
            installRustc = false;
          };
          tsserver.enable = true;
        };
      };

      indent-blankline = {
        enable = true;
        scope.enabled = false;
      };

      gitsigns = {
        enable = true;
        currentLineBlame = true;
        signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
          untracked.text = "▎";
        };
      };

      treesitter = {
        enable = true;
        indent = true;
        nixvimInjections = true;
      };

      treesitter-context.enable = true;

      bufferline.enable = true;
      luasnip.enable = true;
      oil.enable = true;
      comment-nvim.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      fzf-lua
    ];
  };
} 
