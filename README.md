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
DebugTool.assert(MyClass_obj.other_thing == 5, "MyClass_obj.other_thing isn't five")
```

# Modules
### W.I.P:
- **Math**: Useful math functions
- **Vector2**: Simple vec2 system
> NOTE: Modules may be added in the future
### Made:
- **Debug**: Helps to debug with an `assert` function, various types of messages, a *"choose statement"* that displays a message or other depending on a boolean; etc.
- **Timer**: Allows to create timers, has an automatic `update` method and an `onEnd` method that you can customize
- **OOP**: Class system, has: objects *(obviously)*, subclasses, *"merging"* and *"cloning"* classes; etc.
### Considered:
- Message bus

#### Ideas
If you have any module idea open an issue and i will try to answer.

# Roadmap
- Document nicely every method.
- Make every module have the same code structure.
- Make the library lightweight.
- Merge all similar modules. 

# More information
## Inspiration
- 1bardesign/**batteries**: https://github.com/1bardesign/batteries/

## Contributing
To contribute to the project, follow these steps:
1. Fork the repository
2. Make all the changes you consider
3. Make a pull request

# Links
- Repository link: https://github.com/Nykenik24/love2d-tools
- Love2d forum post: https://love2d.org/forums/viewtopic.php?t=96218
