vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.keymaps")
require("core.options")

vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none", bg = "none" })
