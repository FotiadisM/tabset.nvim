local config = require("tabset.config")

local tabset = {}

function tabset.setup(user_config)
	user_config = user_config or {}
	config.set_config(user_config)
end

vim.cmd([[
	augroup tabset
		autocmd FileType * lua require('tabset.logic').set_settings()
	augroup END
]])

return tabset
