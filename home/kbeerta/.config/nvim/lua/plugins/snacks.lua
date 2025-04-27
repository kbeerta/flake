return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        picker = {},
        indent = {
            only_scope = true,
            animate = {
                enabled = false,
            },
        },
    },
    keys = {
        -- find
        { "<leader>ff", function() Snacks.picker.files() end },
        { "<leader>ff", function() Snacks.picker.files() end },
        { "<leader>fb", function() Snacks.picker.buffers() end },
        { "<leader>fr", function() Snacks.picker.recent() end },

        -- search
        { "<leader>sg", function() Snacks.picker.grep() end },
        { "<leader>sj", function() Snacks.picker.jumps() end },
    }
}
