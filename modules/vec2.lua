-- NOTE: MODULE IS W.I.P

local class = require("modules.class")
local vec2 = {}
vec2.x = 0
vec2.y = 0
vec2.angle = 0
vec2.magnitude = 0

---@class Vector2
---@field x number
---@field y number
---@field angle number
---@field magnitude number

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

---Add the vector with another vector
---@param self Vector2
---@param b Vector2 Second vector
---@return Vector2
function vec2.Add(self, b)
	local c = self
	c.x = self.x + b.x
	c.y = self.y + b.y
	return c
end

---Subtract the vector with another vector
---@param self Vector2
---@param b Vector2 Second vector
---@return Vector2
function vec2.Sub(self, b)
	local c = self
	c.x = self.x - b.x
	c.y = self.y - b.y
	return c
end

---Compare "x" and "y" of two vectors
---@param self Vector2
---@param b Vector2 Second vector
---@return Vector2 Winner
function vec2.Compare(self, b)
	if self.x > b.x and self.y > b.y then
		return self
	else
		return b
	end
end

---Compare "x" of two vectors
---@param self Vector2
---@param b Vector2 Second vector
---@return Vector2 Winner
function vec2.CompareX(self, b)
	if self.x > b.x then
		return self
	else
		return b
	end
end

---Compare "y" of two vectors
---@param self Vector2
---@param b Vector2 Second vector
---@return Vector2
function vec2.CompareY(self, b)
	if self.y > b.y then
		return self
	else
		return b
	end
end

---Rotate the vector.
---
---To overwrite the angle use SetAngle()
---@param self Vector2
---@param angle number Target rotation
---@return number
function vec2.Rotate(self, angle)
	local max_angle = math.pi * 2

	local final_angle = self.angle + angle
	if final_angle > max_angle then
		final_angle = 0 + (math.max(max_angle, angle) - math.min(max_angle, angle))
	elseif final_angle < 0 then
		final_angle = max_angle - (math.max(max_angle, angle) - math.min(max_angle, angle))
	end

	self.angle = final_angle
	return final_angle
end

---Moves (Adds to the position) the vector.
---@param self Vector2
---@param x number Number added to the x position.
---@param y number Number added to the y position.
---@return Vector2
function vec2.Move(self, x, y)
	local moved_vector = self
	moved_vector.x = self.x + x
	moved_vector.y = self.y + y

	self = moved_vector
	return moved_vector
end

---Translates (Overwrites the position) the vector.
---@param self Vector2
---@param x number Target x position
---@param y number Target y position
---@return Vector2
function vec2.Translate(self, x, y)
	self.x = x
	self.y = y

	return self
end

---Draw the vector
---@param self Vector2
---@param orig_x? number X original point. Default = center of screen
---@param orig_y? number Y original point. Default = center of screen
function vec2.Draw(self, orig_x, orig_y)
	orig_x, orig_y = love.graphics:getWidth() / 2, love.graphics:getHeight() / 2
	love.graphics.line(orig_x, orig_y, self.x, self.y)
end

local vec2_class = class(vec2)

local function new(x, y)
	local obj = vec2_class:new()
	obj.x = x
	obj.y = y
	return obj
end

return new
