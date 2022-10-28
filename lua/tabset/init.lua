local M = {}

M.setup = function(user_config)
	user_config = user_config or {}
	require("tabset.config").set_config(user_config)
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("tabset", { clear = true }),
	callback = function()
		require("tabset.logic").set_settings()
	end,
})

return M
