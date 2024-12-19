local class = require("modules.class")

local timer = {}
timer.orig = 0
timer.seconds = 0
timer.rounded_seconds = math.floor(timer.seconds)

timer.elapsed = false

---Update the timer.
---@param self table
---@param dt integer
---@return integer self.secs Time countdown.
---@return boolean elapsed True if the timer ended.
function timer:Update(dt)
	if self.seconds > 0 then
		self.seconds = self.secs - dt
	elseif self.seconds < 0 then
		self.seconds = 0
		self.elapsed = true
		return self.seconds, true
	end
	if self.elapsed then
		self.elapsed = false
		self:Reset()
		self:OnEnd()
	end

	self.rounded_seconds = math.floor(self.seconds)
	return self.seconds, false
end

---Reset the timer to the original duration (or another duration).
---@param self table
---@param new_duration? integer
---@return integer self.secs Time countdown.
function timer:Reset(new_duration)
	if not new_duration then
		self.seconds = self.orig
	else
		self.seconds = new_duration
	end
	self.elapsed = false
	return self.seconds
end

timer.OnEnd = function(self)
	print(("Timer %s ended!"):format(tostring(self)))
end

local timer_class = class(timer)

---Create a new timer.
---@param duration integer
---@return table
local function new(duration)
	local timer_obj = timer_class:new()
	timer_obj.seconds = duration
	timer_obj.orig = duration
	return timer_obj
end

return new
