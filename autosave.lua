local bufnr = 10
vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { "hello", "world" })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("testfromTJ", { clear = true}),
	pattern = "autosave.lua",
	callback = function()
		print("file saved!")
	end,
})
