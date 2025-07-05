local M = {}

M.map = function(mode, lhs, rhs, opts)
    local opts = vim.tbl_extend("force", opts or {}, { noremap = true, silent = true })
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
