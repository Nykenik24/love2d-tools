--- Utility to get the folder of the script being executed.
--- This fetches the path from the root directory in which the script is located.
---@return string path The directory path where the script is running.
local function getScriptFolder()
	return (debug.getinfo(1, "S").source:sub(2):match("(.*/)"))
end

-- Internal logger state and thread management
---@class loggerinternal
local loggerinternal = {}
loggerinternal.write = love.thread.newThread(getScriptFolder() .. "loggerthread.lua") -- Thread to handle logging operations.
loggerinternal.datastack = love.thread.getChannel("loggerdata") -- Data channel for sending logs to the thread.

-- Logger module
---@class logger
---@field regular function Regular message
---@field trace function Trace message
---@field debug function Debug message
---@field info function Information message
---@field ok function Indicates something works/worked
---@field warn function Warning
---@field error function Error
---@field fatal function Fatal error
local logger = {}

---@alias log_types
---| `"regular"`
---| `"trace"`
---| `"debug"`
---| `"info"`
---| `"ok"`
---| `"warn"`
---| `"error"`
---| `"fatal"`
local log_types = {
	regular = "\27[37m",
	trace = "\27[34m",
	debug = "\27[36m",
	info = "\27[32m",
	ok = "\27[32m",
	warn = "\27[33m",
	error = "\27[31m",
	fatal = "\27[35m",
}

local clear_color = "\27[0;0m"
for k, v in pairs(log_types) do
	---@param content string Log content
	logger[k] = function(content)
		loggerinternal.datastack:push(
			("%s[%s %s]:%s %s"):format(v, tostring(os.date("%H:%M:%S")), k:upper(), clear_color, content)
		)
	end
end

--- Starts the logging service by starting the thread.
function logger.startSVC()
	loggerinternal.write:start()
end

--- Stops the logging service by signaling the thread to stop and waiting for it to finish.
function logger.stopSVC()
	loggerinternal.datastack:push("STOP") -- Signal to stop the logger thread.
	loggerinternal.write:wait() -- Wait for the thread to finish execution.
end

return logger
