--[[
    Higher order function for creating runtime module loaders.

    table modules: List of all runtime modules to load. Storing your modules in a
        Folder allows you to easily run GetChildren() to get this list.

    Usage:

        local modules = script.runtime:GetChildren()
        local loadModules = createLoader()
        loadModules(modules)

        -- You can optionally pass in arguments that will be used for each
        -- runtime module. Helpful for supplying globally shared data, without
        -- having the modify the environment.
        local loadModules = createLoader("foo", "bar")
		loadModules(modules)
]]

local loadModule = require(script.Parent.loadModule)

local LOAD_MESSAGE = "Loaded %s successfully (%.2fms)"

local function _load(module, args)
	local loadTime = loadModule(module, args)
	print(LOAD_MESSAGE:format(module.Name, loadTime))
end

local function createLoader(...)
	local args = { ... }
	return function(modules)
		for _, module in pairs(modules) do
			coroutine.wrap(_load)(module, args)
        end
    end
end

return createLoader
