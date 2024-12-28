local function getScriptFolder() --* get the path from the root folder in which THIS script is running
	return (debug.getinfo(1, "S").source:sub(2):match("(.*/)"))
end
---@type Math
local mathx = require(getScriptFolder() .. "math")

---@class EasingHelper
local M = {}

---Linear interpolation between two values
---@param start number Starting value
---@param ending number Ending value
---@param factor number Interpolation factor. Range: 0-1
---@return number Interpolated Interpolated value
function M.LinearInterpolation(start, ending, factor)
	return mathx.Lerp(start, ending, factor)
end

---Smooth interpolation between two values using a cubic curve
---@param edge_1 number Lower edge
---@param edge_2 number Upper edge
---@param val number Target value
---@return number Interpolated Smoothed value
function M.SmoothInterpolation(edge_1, edge_2, val)
	local clamp = mathx.Clamp
	val = clamp((val - edge_1) / (edge_2 - edge_1), 0.0, 0.1)
	return (val ^ 2) * (3 - 2 * val)
end

--functions from https://github.com/EmmanuelOga/easing/blob/master/lib/easing.lua
--easing equations from http://robertpenner.com/easing/
--both licenses are in the "modules/licenses/" files
---@diagnostic disable: unused-local

local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin = math.asin

---Ease linearly
---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function Linear(t, b, c, d)
	return c * t / d + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InQuad(t, b, c, d)
	t = t / d
	return c * pow(t, 2) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutQuad(t, b, c, d)
	t = t / d
	return -c * t * (t - 2) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutQuad(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 2) + b
	else
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInQuad(t, b, c, d)
	if t < d / 2 then
		return OutQuad(t * 2, b, c / 2, d)
	else
		return InQuad((t * 2) - d, b + c / 2, c / 2, d)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InCubic(t, b, c, d)
	t = t / d
	return c * pow(t, 3) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutCubic(t, b, c, d)
	t = t / d - 1
	return c * (pow(t, 3) + 1) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutCubic(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * t * t * t + b
	else
		t = t - 2
		return c / 2 * (t * t * t + 2) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInCubic(t, b, c, d)
	if t < d / 2 then
		return OutCubic(t * 2, b, c / 2, d)
	else
		return InCubic((t * 2) - d, b + c / 2, c / 2, d)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InQuart(t, b, c, d)
	t = t / d
	return c * pow(t, 4) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutQuart(t, b, c, d)
	t = t / d - 1
	return -c * (pow(t, 4) - 1) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutQuart(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 4) + b
	else
		t = t - 2
		return -c / 2 * (pow(t, 4) - 2) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInQuart(t, b, c, d)
	if t < d / 2 then
		return OutQuart(t * 2, b, c / 2, d)
	else
		return InQuart((t * 2) - d, b + c / 2, c / 2, d)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InQuint(t, b, c, d)
	t = t / d
	return c * pow(t, 5) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutQuint(t, b, c, d)
	t = t / d - 1
	return c * (pow(t, 5) + 1) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutQuint(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 5) + b
	else
		t = t - 2
		return c / 2 * (pow(t, 5) + 2) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInQuint(t, b, c, d)
	if t < d / 2 then
		return OutQuint(t * 2, b, c / 2, d)
	else
		return InQuint((t * 2) - d, b + c / 2, c / 2, d)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InSine(t, b, c, d)
	return -c * cos(t / d * (pi / 2)) + c + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutSine(t, b, c, d)
	return c * sin(t / d * (pi / 2)) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutSine(t, b, c, d)
	return -c / 2 * (cos(pi * t / d) - 1) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInSine(t, b, c, d)
	if t < d / 2 then
		return OutSine(t * 2, b, c / 2, d)
	else
		return InSine((t * 2) - d, b + c / 2, c / 2, d)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InExpo(t, b, c, d)
	if t == 0 then
		return b
	else
		return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutExpo(t, b, c, d)
	if t == d then
		return b + c
	else
		return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutExpo(t, b, c, d)
	if t == 0 then
		return b
	end
	if t == d then
		return b + c
	end
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
	else
		t = t - 1
		return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInExpo(t, b, c, d)
	if t < d / 2 then
		return OutExpo(t * 2, b, c / 2, d)
	else
		return InExpo((t * 2) - d, b + c / 2, c / 2, d)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InCirc(t, b, c, d)
	t = t / d
	return (-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutCirc(t, b, c, d)
	t = t / d - 1
	return (c * sqrt(1 - pow(t, 2)) + b)
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutCirc(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return -c / 2 * (sqrt(1 - t * t) - 1) + b
	else
		t = t - 2
		return c / 2 * (sqrt(1 - t * t) + 1) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInCirc(t, b, c, d)
	if t < d / 2 then
		return OutCirc(t * 2, b, c / 2, d)
	else
		return InCirc((t * 2) - d, b + c / 2, c / 2, d)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InElastic(t, b, c, d, a, p)
	if t == 0 then
		return b
	end

	t = t / d

	if t == 1 then
		return b + c
	end

	if not p then
		p = d * 0.3
	end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end

	t = t - 1

	return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@param a number Amplitude
---@param p number Period
---@return number Eased Eased value
function OutElastic(t, b, c, d, a, p)
	if t == 0 then
		return b
	end

	t = t / d

	if t == 1 then
		return b + c
	end

	if not p then
		p = d * 0.3
	end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end

	return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@param a number Amplitude
---@param p number Period
---@return number Eased Eased value
function InOutElastic(t, b, c, d, a, p)
	if t == 0 then
		return b
	end

	t = t / d * 2

	if t == 2 then
		return b + c
	end

	if not p then
		p = d * (0.3 * 1.5)
	end
	if not a then
		a = 0
	end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end

	if t < 1 then
		t = t - 1
		return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
	else
		t = t - 1
		return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) * 0.5 + c + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@param a number Amplitude
---@param p number Period
---@return number Eased Eased value
function OutInElastic(t, b, c, d, a, p)
	if t < d / 2 then
		return OutElastic(t * 2, b, c / 2, d, a, p)
	else
		return InElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InBack(t, b, c, d, s)
	if not s then
		s = 1.70158
	end
	t = t / d
	return c * t * t * ((s + 1) * t - s) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutBack(t, b, c, d, s)
	if not s then
		s = 1.70158
	end
	t = t / d - 1
	return c * (t * t * ((s + 1) * t + s) + 1) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutBack(t, b, c, d, s)
	if not s then
		s = 1.70158
	end
	s = s * 1.525
	t = t / d * 2
	if t < 1 then
		return c / 2 * (t * t * ((s + 1) * t - s)) + b
	else
		t = t - 2
		return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInBack(t, b, c, d, s)
	if t < d / 2 then
		return OutBack(t * 2, b, c / 2, d, s)
	else
		return InBack((t * 2) - d, b + c / 2, c / 2, d, s)
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutBounce(t, b, c, d)
	t = t / d
	if t < 1 / 2.75 then
		return c * (7.5625 * t * t) + b
	elseif t < 2 / 2.75 then
		t = t - (1.5 / 2.75)
		return c * (7.5625 * t * t + 0.75) + b
	elseif t < 2.5 / 2.75 then
		t = t - (2.25 / 2.75)
		return c * (7.5625 * t * t + 0.9375) + b
	else
		t = t - (2.625 / 2.75)
		return c * (7.5625 * t * t + 0.984375) + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InBounce(t, b, c, d)
	return c - OutBounce(d - t, 0, c, d) + b
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function InOutBounce(t, b, c, d)
	if t < d / 2 then
		return InBounce(t * 2, 0, c, d) * 0.5 + b
	else
		return OutBounce(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b
	end
end

---@param t number Time/Value, goes from 0 to "d" (Duration)
---@param b number Begin/Start
---@param c number Change/End
---@param d number Duration
---@return number Eased Eased value
function OutInBounce(t, b, c, d)
	if t < d / 2 then
		return OutBounce(t * 2, b, c / 2, d)
	else
		return InBounce((t * 2) - d, b + c / 2, c / 2, d)
	end
end

return M
