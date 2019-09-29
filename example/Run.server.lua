local Bootstrap = require(game.ReplicatedStorage.Bootstrap)

local loadModules = Bootstrap.createLoader("foo", "bar")
loadModules(script.Parent.Modules:GetChildren())
