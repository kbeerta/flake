vim.pack.add({ 
    "https://github.com/folke/snacks.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter"
})

local utils = require("core.utils")

require("oil").setup({
    columns = {},
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
    },
    lsp_file_methods = { enabled = true },
})

utils.map("n", "-", "<cmd>Oil<CR>")

require("snacks").setup({
    picker = {},
    indent = {
        only_scope = true,
        animate = {
            enabled = false,
        },
    },
})

utils.map("n", "<leader>ff", Snacks.picker.files)
utils.map("n", "<leader>fb", Snacks.picker.buffers)
utils.map("n", "<leader>fr", Snacks.picker.recent)

utils.map("n", "<leader>sg", Snacks.picker.grep)
utils.map("n", "<leader>sj", Snacks.picker.jumps)
