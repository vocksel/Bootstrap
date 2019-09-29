# GameLoader

Instead of using Scripts or LocalScripts, all of your runtime code is made up of ModuleScripts that get required. Each module returns a function, and that function is called by GameLoader to run it.

This puts you in a setup of only having one Script and LocalScript which load all the runtime modules associated with the server or client, respectively.

Runtime modules work the same as Scripts and LocalScripts, with the key difference of allowing you to pass in globals instead of having to modify the environment, as well as being able to control _when_ your code executes. With GameLoader, you can run some setup code before you actually load the rest of your game.

## Installation

**Model File (Roblox Studio)**
- Download the `rbxmx` model file attached to the latest release from the [GitHub releases page](https://github.com/vocksel/game-loader/releases).
- Insert the model into Studio into a place like `ReplicatedStorage`

**Filesystem**
- Copy the `lib` directory into your codebase
- Rename the folder to `GameLoader`
- Use a plugin like [Rojo](https://github.com/rojo-rbx/rojo) to sync the files into a place

## Usage

In this example, we define two runtime modules, A and B. These modules are passed into the loadModules function and get executed.

```lua
-- ServerScriptService.Modules.A (ModuleScript)
return function()
	print("Hello from A!")
end

-- ServerScriptService.Modules.B (ModuleScript)
return function(foo, bar)
	print("Hello from B!")
	print("Arguments:", foo, bar)
end

-- Run (Script)
local GameLoader = require(game.ReplicatedStorage.GameLoader)

local loadModules = GameLoader.createLoader("foo", "bar")
loadModules(script.Parent.Modules:GetChildren())
```

This prints:

```
Hello from A!
Loaded A successfully (0.81ms)
Hello from B!
Arguments: foo bar
Loaded B successfully (1.01ms)
```

Note that the order these modules run in will vary! A new thread is created for each module, so if one of your modules takes a long time to load it will load after your faster modules.
