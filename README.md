# Love2d tools
Love2d utilities

## Installation
1. Clone the repository
```bash
git clone https://github.com/Nykenik24/love2d-tools.git
```

2. Require the library in your `main.lua` or the file where you load libraries.
```lua
Tools = require("love2d-tools.lib")
-- or you can require every module individually
Class = require("love2d-tools.modules.class")
```

3. Now you can use the library, all the modules are documented.
```lua
Tools = require("love2d-tools.lib")
ClassTool = Tools.class
DebugTool = Tools.debug --note that lua already has a standard debug library, so don't name the module "debug".
TimerTool = Tools.timer

MyClass = ClassTool {
    smth = "Hello World!",
    other_thing = 5
}
MyClass_obj = MyClass:new()

DebugTool.regular(MyClass_obj.smth)
DebugTool.choose(
    MyClass_obj._is(MyClass), --Boolean
    "info", --True message type
    "error", --False message type
    "MyClass_obj is a MyClass object", --True message
    "MyClass_obj isn't a MyClass object" --False message
)

MyTimer = Timer(5) --5 is the duration of the timer
MyTimer:Update()

MyTimer.OnEnd = function(self) --will be called every time the timer ends
    DebugTool.assert(MyClass_obj.other_thing == 5, "MyClass_obj.other_thing isn't five")
end
```

# Modules
### W.I.P:
- **Math**: Useful math functions
> NOTE: Modules may be added in the future
### Made:
- **Debug**: Helps to debug with an `assert` function, various types of messages, a *"choose statement"* that displays a message or other depending on a boolean; etc.
- **Timer**: Allows to create timers, has an automatic `update` method and an `onEnd` method that you can customize
- **OOP**: Class system, has: objects *(obviously)*, subclasses, *"merging"* and *"cloning"* classes; etc.
- **Vector2**: Simple vec2 system
### Considered:
- Message bus

#### Ideas
If you have any module idea open an issue and i will try to answer.

# Roadmap
- Document nicely every method.
- ~Make every module have the same code structure.~
- ~Merge all similar modules.~ 
- Finish all modules.

# More information
## Inspiration
- 1bardesign/**batteries**: https://github.com/1bardesign/batteries/

## Contributing
To contribute to the project, follow these steps:
1. Fork the repository
2. Make all the changes you consider
3. Make a pull request

## Making modules
I'll explain to you how i make every module. This can help if you want to [contribute](README#Contributing).\
\
1. Create the file
When creating the files i try to name them as short as possible, without using more than one word. This is because is way more easy to manage files with simple names and for you to understand
what every module does looking at the file name.
2. Write the module base
Every module has this base:
```lua
local M = {}

return M
```
Some modules are classes, so i need to add some extra lines.
```lua
local class = require("modules.class")
local M = {}

local M_class = class(M)
return M_class
```
3. Make every method and variable
Now that i have the module base, i need to make every method and every variable.
```lua
local class = require("modules.class")
local M = {}
M.SomeRandomVariable = "!dlroW olleH"

function M.SomeRandomMethod(self)
    return self.SomeRandomVariable
end

local M_class = class(M)
return M_class
```
But, wait. If you view the modules that are classes, you will see how they have a `new()` method being returned.
```lua
local function new()
    return M_class:new()
end
```
Some modules have a variable declared when creating a new object
```lua
local function new(a, b)
    local obj = M_class:new()
    obj.a = a
    obj.b = b

    return obj
end
```
4. Documenting
Here i just use lua annotations of their default lsp that everyone uses to make using the modules easier and not needing former documentation in some documentation host like `readthedocs`.
```lua
---@param a number Number "a"
---@param b number Number "b"
---@return number Sum
function M.Add(a, b)
    return a + b
end
```
5. Final steps
After finishing the module, i check that the code is correct, look for spelling errors and all of that boring ~crap~.\
\
Then i add it to `lib.lua`
```lua
<module_name> = require("modules.<module_name>")
```
\\
And finally i just commit and push the changes to the repo.
```bash
git add . # my alias: ga .
git commit -m 'Finished module "<module_name>"' # my alias: gcmsg <message>
git push origin main # my alias: ggpush
```

# Links
- Repository link: [github.com/Nykenik24/love2d-tools](https://github.com/Nykenik24/love2d-tools)
- Love2d forum post: [love2d.org/forums/viewtopic.php?t=96218](https://love2d.org/forums/viewtopic.php?t=96218)
