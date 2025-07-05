vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

local servers = {
	"nixd",
	"rust_analyzer",
}

for _, lsp in pairs(servers) do
	vim.lsp.enable(lsp)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ async = true, bufnr = args.buf, id = client.id, timeout_ms = 1000 })
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

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float({
			scope = "cursor",
			focusable = false,
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"InsertEnter",
				"WinLeave",
			},
		})
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
})
