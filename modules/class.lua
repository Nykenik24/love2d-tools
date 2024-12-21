local M = {}

---New object.
---@param self class
---@return table
function M.new(self)
	local obj = {}
	for k, v in pairs(self.attributes) do
		obj[k] = v
	end
	obj._is = M.is
	return obj
end

---Create subclass.
---@param self class
---@param name string
---@param attributes table
---@return class
function M.extend(self, name, attributes)
	self.sub[name] = setmetatable(M.NewClass(attributes), self._mt)
	return self.sub[name]
end

---Check if object comes from a class.
---@param obj table
---@param class class
---@return boolean
function M.is(obj, class)
	local obj_mt = getmetatable(obj)
	local class_mt = getmetatable(class._mt)
	if obj_mt == class_mt then
		return true
	else
		return false
	end
end

---Clone a class.
---@param class class
---@return class
function M.clone(class)
	return M.NewClass(class.attributes)
end

---Merge two classes.
---@param class1 class
---@param class2 class
---@return class
function M.merge(class1, class2)
	local merged = {
		class1 = class1.attributes,
		class2 = class2.attributes,
	}
	local final = {}
	for _, class in pairs(merged) do
		for k, var in pairs(class) do
			final[k] = var
		end
	end
	return M.NewClass(final)
end

function M.NewClass(attributes)
	---@class class
	---@field attributes table Vars
	---@field sub table Subclasses
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

return M.NewClass
