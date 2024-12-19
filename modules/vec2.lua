-- NOTE: MODULE IS W.I.P

local class = require("modules.class")
local vec2 = {}
vec2.x = 0
vec2.y = 0
vec2.angle = 0
vec2.magnitude = 0

for k, v in pairs(vec2) do
	local formatted_k = k:sub(1, 1):upper() .. k:sub(2, #k) --key "example" turns into "Example"
	vec2[("Get%s"):format(formatted_k)] = function(self)
		return self[k]
	end
	vec2[("Set%s"):format(formatted_k)] = function(self, new_val)
		self[k] = new_val
		return self[k]
	end
end

local vec2_class = class(vec2)

local function new()
	return vec2_class:new()
end

return new
