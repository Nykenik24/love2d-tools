# Love2d tools
Love2d utilities

## Installation
1. Clone the repository
```bash
git clone https://github.com/Nykenik24/love2d-tools.git
```

2. Require the library in your `main.lua` or the file where you load libraries.
```lua
Tools = require("love2d-tools.love2d-tools")
-- or you can require every module individually
Class = require("love2d-tools.modules.class")
```

3. Now you can use the library, all the modules are documented.
```lua
Tools = require("love2d-tools.love2d-tools")
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

## Modules
### Planned:
- Math
- Vector2
- Message bus
> NOTE: Modules may be added in the future
### Made:
- Debug
- Timer
- OOP

## Changelog

### First log
#### Added modules:
- Debug
- Timer
- OOP

#### README.md changes:
- Added installation guide

#### Notes:
I had these modules already made, but i had to change completely the `class` module because i had public and private variables, but they weren't necessary.

## Inspiration
- 1bardesign/**batteries**: https://github.com/1bardesign/batteries/

## Contributing
To contribute to the project, follow these steps:
1. Fork the repository
2. Make all the changes you consider
3. Make a pull request
