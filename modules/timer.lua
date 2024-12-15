---Create a new timer.
---@param duration integer
---@return timer
local function new(duration)
  ---@class timer
  ---@field orig integer The original duration.
  ---@field rounded_secs integer Time countdown (rounded).
  ---@field secs integer Time countdown.
  ---@field elapsed boolean Timer ended.
  ---@field update function
  ---@field reset function
  return {
    orig = duration,
    rounded_secs = 0,
    secs = duration,
    elapsed = false,
    ---Update the timer.
    ---@param self timer
    ---@param dt integer
    ---@return integer self.secs Time countdown.
    ---@return boolean elapsed True if the timer ended.
    update = function(self, dt)
      if self.secs > 0 then
        self.secs = self.secs - dt
      elseif self.secs < 0 then
        self.secs = 0
        self.elapsed = true
        return self.secs, true
      end

      self.rounded_secs = math.floor(self.secs)
      return self.secs, false
    end,
    ---Reset the timer to the original duration (or another duration).
    ---@param self timer
    ---@param new_duration? integer
    ---@return integer self.secs Time countdown.
    reset = function(self, new_duration)
      if not new_duration then
        self.secs = self.orig
      else
        self.secs = new_duration
      end
      self.elapsed = false
      return self.secs
    end,
  }
end

return new
