local defaultConfig = {
	["Debug"] = false,
	["Info"] = true,
	["Warn"] = true,
	["Error"] = true,

	["IncludeTime"] = true,

	["Pattern"] = "[%TYPE | %TIME | %CLASS] - %MESSAGE",
	["ReplacePattern"] = "{}",

	["FunctionCalls"] = {
		["Debug"] = print,
		["Info"] = print,
		["Warn"] = warn,
		["Error"] = error
	}
}

local deepCopy
deepCopy = function(orig)
	local originalType, copy = typeof(orig)

	if (originalType == 'table') then
		copy = { }

		for originalKey, originalValue in next, orig, nil do
			copy[deepCopy(originalKey)] = deepCopy(originalValue)
		end

		setmetatable(copy, deepCopy(getmetatable(orig)))
	else
		copy = orig
	end
	
	return copy
end

local function validateOrFixConfig(config)
	if (typeof(config) ~= "table") then
		return defaultConfig
	end

	local newConfig = deepCopy(defaultConfig)

	for key, value in pairs(config) do
		newConfig[key] = value
	end

	return newConfig
end

return function()
	local Log = BaseClass:new("Log")

	local ClassLog = import("org.log4lua.ClassLog")
	local LogClassLogger = ClassLog(defaultConfig, Log)

	local config = nil

	Log.Log = function(self, giveConfig)
		config = validateOrFixConfig(giveConfig)

		return self
	end

	Log.getLogger = function(self, class)
		if (config == nil) then
			LogClassLogger:atError()
				:addArgument("a config class")
				:addArgument(config)
				:log("Expected: {}, Got: {}")

			return false
		end

		return ClassLog(config, class)
	end

	return Log
end