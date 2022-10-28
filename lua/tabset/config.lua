local M = {
	config = {},
}

local config_defaults = {
	tabwidth = 4,
	expandtab = true,
}

local config_languages = {
	go = {
		tabwidth = 4,
		expandtab = false,
	},
}

local function set_defaults()
	M.config.defaults = config_defaults
	M.config.languages = config_languages
end

local function first_non_null(...)
	local n = select("#", ...)
	for i = 1, n do
		local value = select(i, ...)
		if value ~= nil then
			return value
		end
	end
end

M.set_config = function(user_config)
	local user_defaults = user_config.defaults or {}
	local user_languages = user_config.languages or {}

	for k, v in pairs(config_defaults) do
		M.config.defaults[k] = first_non_null(user_defaults[k], v)
	end

	for k, v in pairs(user_languages) do
		M.config.languages[k] = v

		if type(k) == "string" then
			if M.config.languages[k].tabwidth == nil then
				M.config.languages[k].tabwidth = config_defaults.tabwidth
			end

			if M.config.languages[k].expandtab == nil then
				M.config.languages[k].expandtab = config_defaults.expandtab
			end
		else
			if M.config.languages[k].filetypes == nil then
				M.config.languages[k] = nil
			else
				if M.config.languages[k].config == nil then
					M.config.languages[k].config = config_defaults
				else
					if M.config.languages[k].config.tabwidth == nil then
						M.config.languages[k].config.tabwidth = config_defaults.tabwidth
					end
					if M.config.languages[k].config.expandtab == nil then
						M.config.languages[k].config.expandtab = config_defaults.expandtab
					end
				end
			end
		end
	end
end

M.get_config = function()
	return M.config
end

M.get_defaults = function()
	return M.config.defaults
end

M.get_languages_config = function()
	local lngs = {}

	for l, c in pairs(M.config.languages) do
		if type(l) == "string" then
			lngs[l] = c
		else
			for _, l2 in pairs(c.filetypes) do
				lngs[l2] = c.config
			end
		end
	end

	return lngs
end

set_defaults()

return M
