--[[
	Loads a runtime module.

	A runtime module is any ModuleScript that returns a function. These modules
	are required and optionally passed in arguments by this module.

	Runtime modules allow the control of when code is executed, along with being
	able to pass in helpful globals without modifying the environment. The load
	time is also kept track of, which can be helpful to see.

    Usage:

		local module = game.ReplicatedStorage.ModuleScript
		local loadTime = loadModule(module)

		-- Can optionally supply arguments to the module
		local loadTime = loadModule(module, { "foo", "bar" })
]]

local benchmark = require(script.Parent.benchmark)

local NEEDS_TO_RETURN_FUNCTION = "Runtime module '%s' needs to return a function"

local function loadModule(module, args)
	local timeSpent = benchmark(function()
		local callback = require(module)
		assert(type(callback) == "function", NEEDS_TO_RETURN_FUNCTION:format(module:GetFullName()))
		callback(unpack(args))
	end)

	return timeSpent
end

return loadModule
