if vim.fn.has("nvim-0.8.0") == 0 then
	vim.api.nvim_err_writeln("winbar requires nvim version 0.8 or above")
	return
end

if vim.g.loaded_winbar == 1 then return end
vim.g.loaded_winbar = 1
