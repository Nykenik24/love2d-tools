---@class debug_util
---@field regular function Regular message.
---@field trace function Trace message.
---@field debug function Debug message.
---@field info function Info message.
---@field ok function Good/Ok message.
---@field warn function Warning.
---@field error function Error.
---@field fatal function Fatal error.
local debug_util = {}

---@alias log_types
---| `"regular"`
---| `"trace"`
---| `"debug"`
---| `"info"`
---| `"ok"`
---| `"warn"`
---| `"error"`
---| `"fatal"`
local types = {
	regular = "\27[37m",
	trace = "\27[34m",
	debug = "\27[36m",
	info = "\27[32m",
	ok = "\27[32m",
	warn = "\27[33m",
	error = "\27[31m",
	fatal = "\27[35m",
}
debug_util._chained = {}
ChainNumber = 1

for key, color in pairs(types) do
	debug_util[key] = function(msg)
		local before_msg = color .. "{" .. key:upper() .. "}: "
		local white = "\27[00m"
		print(before_msg .. white .. msg)
		ChainNumber = 1
		return debug_util._chained
	end
	debug_util._chained[key] = function(msg)
		local before_msg = color .. "{CHAINED " .. key:upper() .. " " .. ChainNumber .. "}: "
		local white = "\27[00m"
		print(before_msg .. white .. msg)
		ChainNumber = ChainNumber + 1
		return debug_util._chained
	end
end

---Print a message of type depending if a condition is true or false.
---@param condition boolean
---@param choice_true? string
---@param choice_false? string
---@param msg_true? string
---@param msg_false? string
---@return table
function debug_util.choose(condition, choice_true, choice_false, msg_true, msg_false)
	local func_true = debug_util[choice_true] or debug_util.info
	local func_false = debug_util[choice_false] or debug_util.error
	msg_true = msg_true or "Condition is true"
	msg_false = msg_false or "Condition is false"
	if condition then
		func_true(msg_true)
	else
		func_false(msg_false)
	end
	return debug_util._chained
end

---If a condition is false, log a message as error and optionally execute a function.
---@param condition boolean
---@param msg string
---@param func? function
---@return table
function debug_util.assert(condition, msg, func)
	func = func or function() end
	if not condition then
		debug_util.error(msg)
		func()
	end
	return debug_util._chained
end

---Compare two values.
---@param val1 any
---@param val2 any
---@return table
function debug_util.compare(val1, val2)
	if val1 > val2 then
		debug_util.regular('"value 1" is greater than "value 2"')
	else
		debug_util.regular('"value 1" is smaller than "value 2"')
	end
	return debug_util._chained
end

---Log multiple giving an action stack.
---@param log_stack table[]
function debug_util.multiple_logs(log_stack)
	for i, log in ipairs(log_stack) do
		local log_type = log.type or log[1]
		local msg = log.msg or log[2]
		local log_func = debug_util._chained[log_type] or debug_util._chained.regular
		log_func(msg)
	end
end

return debug_util
