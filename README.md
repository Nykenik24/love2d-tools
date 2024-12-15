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
Class = require("love2d-tools.modules.class")
MyClass = Class {
    smth = "Hello World!",
    other_thing = 5
}
MyClass_obj = MyClass:new()

print(MyClass_obj.smth)
```

## Modules
### Planned:
- Math
- Vector2
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
