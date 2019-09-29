local GameLoader = require(game.ReplicatedStorage.GameLoader)

local loadModules = GameLoader.createLoader("foo", "bar")
loadModules(script.Parent.Modules:GetChildren())
