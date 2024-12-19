---@class debug_util
---@field regular function Regular message.
---@field trace function Trace message.
---@field debug function Debug message.
---@field info function Info message.
---@field ok function Good/Ok message.
---@field warn function Warning.
---@field error function Error.
---@field fatal function Fatal error.
---@field history table Log history.
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
debug_util.history = {}
ChainNumber = 1

for key, color in pairs(types) do
	debug_util[key] = function(msg)
		local before_msg = color .. "{" .. key:upper() .. "}: "
		local white = "\27[00m"
		print(before_msg .. white .. tostring(msg))
		debug_util.history[#debug_util.history + 1] = msg

		ChainNumber = 1
		return debug_util._chained
	end
	debug_util._chained[key] = function(msg)
		local before_msg = color .. "{CHAINED " .. key:upper() .. " " .. ChainNumber .. "}: "
		local white = "\27[00m"
		print(before_msg .. white .. tostring(msg))
		debug_util.history[#debug_util.history + 1] = msg

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
function debug_util.Choose(condition, choice_true, choice_false, msg_true, msg_false)
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
function debug_util.Assert(condition, msg, func)
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
function debug_util.Compare(val1, val2)
	if val1 > val2 then
		debug_util.regular('"value 1" is greater than "value 2"')
	else
		debug_util.regular('"value 1" is smaller than "value 2"')
	end
	return debug_util._chained
end

---Log multiple giving an action stack.
---@param log_stack table[]
function debug_util.MultipleLogs(log_stack)
	for i, log in ipairs(log_stack) do
		local log_type = log.type or log[1]
		local msg = log.msg or log[2]
		local log_func = debug_util._chained[log_type] or debug_util._chained.regular
		log_func(msg)
	end
end

---Print a table in a readable format
---@param t table
---@param depth? integer Used to make the function recursive
function debug_util.PrintTable(t, depth)
	local function Tabs(n)
		local tabs = ""
		for _ = 1, n do
			tabs = tabs .. "\t"
		end
		return tabs
	end

	depth = depth or 1
	local tabs = Tabs(depth)
	local start = tabs .. "%s = {"
	local formatted_start = start:format(tostring(t))
	print("\27[1;34m " .. formatted_start:sub(#"table: " + 2, #formatted_start))
	for k, v in pairs(t) do
		if type(k) == "number" and type(v) ~= "table" then
			print("\27[0;32m " .. (tabs .. "[%i] \27[0;0m= "):format(k) .. "\27[0;0m" .. tostring(v))
		elseif type(k) == "string" and type(v) ~= "table" then
			print("\27[0;35m " .. (tabs .. "[%s] \27[0;0m= "):format(k) .. "\27[0;0m" .. tostring(v))
		end

		if type(v) == "table" then
			debug_util.PrintTable(v, depth + 1)
		end
	end
	if depth > 1 then
		print(Tabs(depth - 1) .. "}")
	else
		print("\27[1;34m } \27[0;0m")
	end
end

---Get the log history.
---@return table
function debug_util:GetHistory()
	return self.history
end

---Set the log history.
---@param new_history table
function debug_util:SetHistory(new_history)
	self.history = new_history
	return self.history
end

---Clear the log history.
---@return table
function debug_util:ClearHistory()
	self.history = {}
	return self.history
end

return debug_util
