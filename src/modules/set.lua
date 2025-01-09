local function getScriptFolder() --* get the path from the root folder in which THIS script is running
	return (debug.getinfo(1, "S").source:sub(2):match("(.*/)"))
end
local class = require(getScriptFolder() .. "class")

---@class Set
local M = {}

-- find values --

---Returns true if `val` is in the set.
---@param self Set
---@param val any Value
---@return boolean Inside
function M.Contains(self, val)
	for _, v in ipairs(self) do
		if v == val then
			return true
		end
	end
	return false
end

---Returns index of an specific value. Returns `nil` if value was not found.
---@param self Set
---@param val any Value
---@return integer|nil Index
function M.IndexOf(self, val)
	for i, v in ipairs(self) do
		if v == val then
			return i
		end
	end
	return nil
end

-- insert/remove values --

---Adds a value to the set in a specific position or at the end, **only if the value is not already in the set**.
---@param self Set
---@param val any Value
---@param pos? integer Position of the value
---@return boolean Succes True if value was inserted, false otherwise
function M.Insert(self, val, pos)
	pos = pos or #self
	if self:Contains(val) then
		return false
	end
	table.insert(self, pos, val)
	return true
end

---Removes a value of the set in a specific position.
---@param self Set
---@param pos integer Position
---@return boolean Succes True if value was removed, false otherwise
function M.Remove(self, pos)
	if self[pos] then
		table.remove(self, pos)
		return true
	else
		return false
	end
end

-- last, first & pop --

---Removes and returns last value.
---@param self Set
---@return any Value Last value
function M.Pop(self)
	return table.remove(self, #self)
end

---Returns last value
---@param self Set
---@return any Last Last value
function M.Last(self)
	return self[#self]
end

---Returns first value
---@param self Set
---@return any First First value
function M.First(self)
	return self[1]
end

-- filter values --

---Filters values by **type**.
---@param self Set
---@param target_type type Type to filter by
---@return table Filtered Filtered elements
function M.FilterByType(self, target_type)
	local filtered = {}
	for i, v in ipairs(self) do
		if type(v) == target_type then
			table.insert(filtered, v)
		end
	end
	return filtered
end

---Filters values **excluding** the ones that are of an specific **type**.
---@param self Set
---@param target_type type Type to filter by
---@return table Filtered Filtered elements
function M.FilterExcludeType(self, target_type)
	local filtered = {}
	for i, v in ipairs(self) do
		if type(v) ~= target_type then
			table.insert(filtered, v)
		end
	end
	return filtered
end

---Filters values by **length** (also excludes values that are not `string`s or `table`s).
---@param self Set
---@param length integer Length to filter by
---@return table Filtered Filtered elements
function M.FilterByLength(self, length)
	local filtered = {}
	for i, v in ipairs(self) do
		if (type(v) == "table" or type(v) == "string") and #v == length then
			table.insert(filtered, v)
		end
	end
	return filtered
end

-- iteration --

---For each element in table calls `func(element [, user_arguments])`.
---@param self Set
---@param func function Function called
---@param ... any Other arguments
---@return boolean Finished
function M.ForEach(self, func, ...)
	for i, v in ipairs(self) do
		func(v, ...)
	end
	return true
end

-- misc --

---Returns elements of set from `pos1` to `pos2`.
---@param self Set
---@param pos1 integer Position 1
---@param pos2 integer Position 2
---@return table Selected
function M.Select(self, pos1, pos2)
	local selected = {}
	for i = pos1, pos2 do
		local v = self[i]
		if v == nil then
			break
		end
		table.insert(selected, v)
	end
	return selected
end

---Removes all elements in the set.
---@param self Set
---@return boolean Succes
function M.Clear(self) --was going to call it "Purge", then thinked about it for 2 seconds.
	--iterate in reverse so values don't change position
	for i = #self, 1, -1 do --for i = (end of set), (start of set), (decrease by 1) do
		table.remove(self, i)
	end
	return true
end

local M_class = class(M)

local function new(...)
	local set = M_class:new()
	local vals = { ... }
	for i, v in ipairs(vals) do
		set:Insert(v)
	end
	return set
end

return new
