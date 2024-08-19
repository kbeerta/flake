
vim.g.mapleader = " "
vim.g.localmapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.schedule(function() 
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

vim.opt.scrolloff = 10

vim.g.netrw_banner = 0

vim.keymap.set("n", "-", "<cmd>Ex<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<S-h>", "<cmd>bp<CR>")
vim.keymap.set("n", "<S-l>", "<cmd>bn<CR>")

vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")

local core = require("core")

core.lsp.setup({
  servers = {
    zls = {
      name = "zls",
      cmd = { "zls" },
      filetypes = { "zig", "zir" },
      root_dir = vim.fs.root(0, { "zls.json", "build.zig" }),
      single_file_support = true,
    },
    rust_analyzer = {
      name = "rust-analyzer",
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
      root_dir = vim.fs.root(0, { "Cargo.toml" }),
      single_file_support = true,
    },
  }
})

core.theme.setup()
