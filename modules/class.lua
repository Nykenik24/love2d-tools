---@class Class
---@field attributes table Attributes of the class
---@field sub table Subclasses
---@field _mt table Metatable
local M = {}

---Create new object.
---@param self Class
---@return table
function M.new(self)
	local obj = {}
	for k, v in pairs(self.attributes) do
		obj[k] = v
	end
	obj._is = is
	return obj
end

---Create sub class.
---@param self Class Parent
---@param name string Name of the subclass
---@param attributes table Attributes of the subclass
---@return Class
function M.extend(self, name, attributes)
	self.sub[name] = setmetatable(NewClass(attributes), self._mt)
	return self.sub[name]
end

---Check if object comes from a Class.
---@param obj table
---@param Class Class
---@return boolean
---@diagnostic disable-next-line: lowercase-global
function is(obj, Class)
	local obj_mt = getmetatable(obj)
	local Class_mt = getmetatable(Class._mt)
	if obj_mt == Class_mt then
		return true
	else
		return false
	end
end

---Create a copy of the class.
---@param self Class Class to copy
---@return Class Copy Copy of the class
function M.clone(self)
	return NewClass(self.attributes)
end

---Merge with another class.
---@param self Class
---@param Class2 Class Class to merge with
---@return Class
function M.merge(self, Class2)
	local merged = {
		self = self.attributes,
		Class2 = Class2.attributes,
	}
	local final = {}
	for _, Class in pairs(merged) do
		for k, var in pairs(Class) do
			final[k] = var
		end
	end
	return NewClass(final)
end

---Create a new Class
---@param attributes table
---@return Class
function NewClass(attributes)
	local cls = {
		attributes = {},
		sub = {},
	}
	cls._mt = { _index = cls }
	for k, v in pairs(attributes) do
		cls.attributes[k] = v
	end
	cls.new = M.new
	cls.extend = M.extend
	cls.clone = M.clone
	cls.merge = M.merge
	return cls
end

return NewClass
