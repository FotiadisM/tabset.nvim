local config = {}

config.config = {}

local config_defaults = {
	tabwidth = 4,
	expandtab = true
}

local config_languages = {
	go = {
		tabwidth = 4,
		expandtab = false
	}
}

local function set_defaults()
	config.config.defaults = config_defaults
	config.config.languages = config_languages
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

function config.set_config(user_config)
	local user_defaults = user_config.defaults or {}
	local user_languages = user_config.languages or {}

	for k, v in pairs(config_defaults) do
		config.config.defaults[k] = first_non_null(user_defaults[k], v)
	end

	for k, v in pairs(user_languages) do
		config.config.languages[k] = v

		if type(k) == "string" then
			if config.config.languages[k].tabwidth == nil then
				config.config.languages[k].tabwidth = config_defaults.tabwidth
			end

			if config.config.languages[k].expandtab == nil then
				config.config.languages[k].expandtab = config_defaults.expandtab
			end
		else
			if config.config.languages[k].filetypes == nil then
				config.config.languages[k] = nil
                        else
			if config.config.languages[k].config == nil then
				config.config.languages[k].config = config_defaults
			else
				if config.config.languages[k].config.tabwidth == nil then
					config.config.languages[k].config.tabwidth = config_defaults.tabwidth
				end
				if config.config.languages[k].config.expandtab == nil then
					config.config.languages[k].config.expandtab = config_defaults.expandtab
				end
			end
			end
		end
	end
end

function config.get_config()
	return config.config
end

function config.get_defaults()
	return config.config.defaults
end

function config.get_languages_config()
	local lngs = {}

	for l, c in pairs(config.config.languages) do
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

return config
