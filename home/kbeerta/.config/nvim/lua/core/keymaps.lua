
local M = {}

M.map = function(mode, lhs, rhs, opts)
    local opts = vim.tbl_extend("force", opts or {}, { noremap = true, silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

M.map("n", "<S-l>", "<cmd>bnext<CR>")
M.map("n", "<S-h>", "<cmd>bprevious<CR>")
M.map("n", "<esc>", "<cmd>noh<CR>")

return M
