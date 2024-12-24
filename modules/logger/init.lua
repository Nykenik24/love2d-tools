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
local logger = {}

--- Logs a message to the thread.
---@param name string The name or category of the log (e.g., "ERROR", "INFO").
---@param content string The log message content.
function logger.log(name, content)
    loggerinternal.datastack:push("[" .. tostring(os.time()) .. "]" .. "[" .. name .. "] " .. content)
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
