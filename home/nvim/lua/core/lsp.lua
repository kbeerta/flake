local M = {}

function M.setup(opts) 
  local group = vim.api.nvim_create_augroup("LspStart", { clear = true })

  for name, config in pairs(opts.servers) do
    if vim.fn.executable(opts.servers[name].cmd[1]) ~= 0 then
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = config.filetypes,
        callback = function (ev)
          vim.lsp.start(opts.servers[name], { bufnr = ev.buf })
        end,
      })
    end
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttach", { clear = false }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client.supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
      end

      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({bufnr = args.buf, id = client.id})
          end
        })
      end
    end
  })
end

return M
