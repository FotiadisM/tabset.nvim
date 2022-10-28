local languages = require("tabset.config").get_languages_config()
local defaults = require("tabset.config").get_defaults()

local M = {}

M.set_settings = function()
	local tabwidth = defaults.tabwidth
	local expandtab = defaults.expandtab

	if languages[vim.o.filetype] ~= nil then
		tabwidth = languages[vim.o.filetype].tabwidth
		expandtab = languages[vim.o.filetype].expandtab
	end

	vim.o.tabstop = tabwidth
	vim.o.shiftwidth = tabwidth
	vim.o.expandtab = expandtab
end

return M
