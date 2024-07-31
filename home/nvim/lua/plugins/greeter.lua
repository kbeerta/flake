
local M = {}

function M.setup_buf_autocmds(buf) 

	local group = vim.api.nvim_create_augroup("Greeter", { clear = true });

	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		buffer = buf,
		desc = "If entering insert mode, change greeter to a normal buffer",
		group = group,
		callback = function()
			local nbuf = vim.api.nvim_create_buf(true, false)
			local win = vim.api.nvim_get_current_win()
			vim.api.nvim_win_set_buf(win, nbuf);

			vim.api.nvim_command("startinsert")
			
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	});
end

function M.greet(buf) 
	local ascii = {}
	table.insert(ascii, "gnom")

	vim.api.nvim_buf_set_option(buf, "modified", false)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "number", false)
	vim.api.nvim_buf_set_option(buf, "relativenumber", false)
	vim.api.nvim_buf_set_option(buf, "list", false)
	vim.api.nvim_buf_set_option(buf, "signcolumn", "no")
	vim.api.nvim_set_current_buf(buf)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, ascii)
end

function M.setup()
		if vim.fn.argc() == 0 or vim.fn.line2byte("$") ~= -1 and vim.opt.insertmode then 
			local buf = vim.api.nvim_create_buf(false, false)
			M.setup_buf_autocmds(buf)
			M.greet(buf)
		end
end

return M
