local log = {}
local history = {}

---Log a message
---@param msg any
function log.log(msg)
	print(tostring(msg))
	history[#history + 1] = msg
end

---Get the log history
---@return table History
function log.getHistory()
	return history
end

---Set the log history
---@param new_history table
---@return table History
function log.setHistory(new_history)
	history = new_history
	return history
end

---Print a table in a readable format
---@param t table
---@param depth? integer Used to make the function recursive
function log.logTable(t, depth)
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
			log.logTable(v, depth + 1)
		end
	end
	if depth > 1 then
		print(Tabs(depth - 1) .. "}")
	else
		print("\27[1;34m } \27[0;0m")
	end
end

return log
