# Love2d tools 💪
> Love2d tools is inspired by [batteries.lua](https://github.com/1bardesign/batteries/).

**Love2d tools** *(or love2d-tools)* is a series of **[LOVE2D game framework](https://love2d.org)** utilities to make developing games with Love2d easier and faster. It can make your game developing
experience a little bit better by providing useful tools that almost every game engine has, but Love2d lacks off.\
\
It comes with OOP, Timers, a Debugging helper, etc. All modules can be seen [here](<README.md#Made modules>).
> note: Love2d tools is **NOT** perfect, and you should know that bugs can occur and that it is currently **Work In Progress**.

## Table of contents
- [Installation](README.md#Installation)
- [Modules](README.md#Modules)
    - [Work in Progress](<README.md#Work in Progress modules>)
    - [Made](<README.md#Made modules>)
    - [Considered](<README.md#Considered modules>)
- [Roadmap](README.md#Roadmap)
- [More information](<README.md#More information>)
    - [Inspiration](README.md#Inspiration)
    - [Contributing](README.md#Contributing)
- [Making modules](<README.md#Making modules>)
- [Links](README.md#Links)

## Installation
1. Clone the repository
```bash
git clone https://github.com/Nykenik24/love2d-tools.git
```
Or add it as a submodule **(recommended)**
```bash
git submodule add https://github.com/Nykenik24/love2d-tools.git path/to/library
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
Here all modules are listed.\
\
If you contribute making a module, list it here with this format:
```markdown
### Made modules
- **ModuleName** (`filename`): Brief description.
```

### Work in Progress modules
- **MessageBus** (`message_bus`): Message bus that handles publishers and suscribers.
- **Easing** (`easing`): Easing helper to make smoother movement or ease values.
- **StateMachine** (`state`): State machine that handles different states
> NOTE: Modules may be added in the future
### Made modules
- **Debug** (`debug`): Helps to debug with an `assert` function, various types of messages, a *"choose statement"* that displays a message or other depending on a boolean; etc.
- **Timer** (`timer`): Allows to create timers, has an automatic `update` method and an `OnEnd` method that you can customize.
- **OOP** (`class`): Class system, has: objects *(obviously)*, subclasses, *"merging"* and *"cloning"* classes; etc.
- **Vector2** (`vec2`): Simple vec2 system.
- **Math** (`math`): Useful math functions not present in `lua` and `love2d`.
- **Database** (`database`): Database-like data managing system. Made by *[zalanwastaken](https://github.com/zalanwastaken)*.
### Considered modules
New ideas will be added here before being added to W.I.P modules.

#### Ideas
If you have any module idea open an issue and i will try to answer.

# Roadmap
- Finish all currently W.I.P modules.
    - Database
    - Message bus
    - Easing
    - State machine
- Extend modules:
    - Debug
    - Vector2

# More information
## Inspiration
- 1bardesign/**batteries**: https://github.com/1bardesign/batteries/

## Contributing
To contribute to the project, follow these steps:
1. Fork the repository
2. Make all the changes you consider
3. Make a pull request

I will try to answer as fast as posible. If i don't answer, [send me an email](mailto:Nykenik24@proton.me).
> If the link doesn't work, my email is Nykenik24@proton.me

### Contributing rules
1. Check the code before making the pull request\
> I am not a code reviewer. I will try to check the code that is merged, but errors can go trough.
2. Try to follow the steps [below](<README.md#Making modules>) when creating the module.
3. Document every method and variable and be consisent with naming conventions.
4. If you are going to make the module a class, `return` a `new()` method, not the class.
5. Comments have to be brief.
6. Make documentation descriptions short and understandable.

# Making modules
I'll explain to you how i make every module. This can help if you want to [contribute](README.md#Contributing).

### 1. Create the file
When creating the files i try to name them as short as possible, without using more than one word. This is because is way more easy to manage files with simple names and for you to understand
what every module does looking at the file name.
### 2. Write the module base
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
### 3. Make every method and variable
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
But, wait. If you see the modules that are classes, you will notice how they have a `new()` method being returned.
```lua
local function new()
    return M_class:new()
end
```
You can also see how some modules have variables being choosen by the user when creating a new object.
```lua
local function new(a, b)
    local obj = M_class:new()
    obj.a = a
    obj.b = b

    return obj
end
```
### 4. Documenting
Here i just use lua annotations of the default `lsp` *(language server)* to make using the modules easier and not needing former documentation in some host like `readthedocs`.
```lua
---@param a number Number "a"
---@param b number Number "b"
---@return number Sum
function M.Add(a, b)
    return a + b
end
```
To add documentation you need to make the `M` variable a class with annotations. If you are using a `new()` method, make it return the module's annotation class:
```lua
---@class Example
local M = {}
local class = require("modules.class")
local M_class = class(M)

---@return Example
local function new()
    return M_class:new()
end
```
### 5. Final steps
After finishing the module, i check that the code is correct, look for spelling errors and all of that boring ~crap~.\
\
Then i add it to `lib.lua` and `README.md` ([README.md format](README.md#Modules))
```lua
-- lib.lua
<module_name> = require("modules.<module_name>")
```
\
And finally i just commit and push the changes to the repo.
```bash
git add . # my alias: ga .
git commit -m 'Finished module "<module_name>"' # my alias: gcmsg <message>
git push origin main # my alias: ggpush
```

# Links
- Repository link: [github.com/Nykenik24/love2d-tools](https://github.com/Nykenik24/love2d-tools)
- Love2d forum post: [love2d.org/forums/viewtopic.php?t=96218](https://love2d.org/forums/viewtopic.php?t=96218)
