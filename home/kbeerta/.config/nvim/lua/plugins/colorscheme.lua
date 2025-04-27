return {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
        variant = "moon",
        extend_background_behind_borders = true,
        styles = {
            bold = true,
            italic = false,
            transparency = true,
        },
    },
    init = function()
        vim.cmd.colorscheme("rose-pine")
    end
}
