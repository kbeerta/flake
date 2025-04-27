
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.keymaps")
require("core.options")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end
            })
        end

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

            vim.api.nvim_create_autocmd({ "TextChangedI" }, {
                buffer = args.buf,
                callback = function()
                    vim.lsp.completion.get()
                end
            })
        end
    end
})

local servers = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
    local name =  vim.fn.fnamemodify(v, ":t:r")
    servers[name] = true
end

vim.lsp.enable(vim.tbl_keys(servers))

vim.diagnostic.config({ 
    virtual_text = {
        current_line = true
    }
})
