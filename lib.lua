local function getScriptFolder() --* get the path from the root folder in which THIS script is running
	return (debug.getinfo(1, "S").source:sub(2):match("(.*/)"))
end
local path = getScriptFolder()
local Tools = {
	---@type DebugUtil
	debug = require(getScriptFolder() .. "modules.debug"),
	---@type Math
	math = require(getScriptFolder() .. "modules.math"),
	---@type Database
	database = require(getScriptFolder() .. "modules.database"),
	---@type messageBus
	messageBus = require(getScriptFolder() .. "modules.messagebus"),
	lib_info = {
		author = "Nykenik24",
		url = "https://github.com/Nykenik24/love2d-tools",
		license = [[
MIT License

Copyright (c) 2024 Nykenik

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
	]],
	},
}

---Create a new class
---@param attributes table
---@return Class
Tools.class = function(attributes)
	return require(path .. "modules.class")(attributes)
end

---Create a new timer
---@param duration number
---@return Timer
Tools.timer = function(duration)
	return require(path .. "modules.class")(duration)
end

---Create a new state machine
---@return StateMachine
Tools.state = function()
	return require(path .. "modules.class")()
end

---Create a new vector
---@param x number
---@param y number
---@return Vector2
Tools.vec2 = function(x, y)
	return require(path .. "modules.class")(x, y)
end

Tools._mt = { _index = Tools }

return Tools
