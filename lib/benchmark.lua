--[[
	Wraps a function in a promise, returning the time it took the function to
	complete (in ms).

	You're expected to call `resolve` manually in the callback function. This
	lets the Promise know when the callback is done.

	Usage:

		local timeSpent = benchmark(function()
			wait(4)
		end)

		print(timeSpent) -- ~4000
]]

local function benchmark(callback)
	local startTime = tick()
	callback()
	return (tick()-startTime)*1000
end

return benchmark
