---@param length number The desired length of the generated ID (default is 16).
---@return string A randomly generated ID of the specified length.
local function idgen(length)
	length = length or 16
	local chars = { -- * Small chars
		"a", --? too long dont you think ? :3
		"b",
		"c",
		"d",
		"e",
		"f",
		"g",
		"h",
		"i",
		"j",
		"k",
		"l",
		"m",
		"n",
		"o",
		"p",
		"q",
		"r",
		"s",
		"t",
		"u",
		"v",
		"w",
		"x",
		"y",
		"z", -- * Capital chars
		"A",
		"B",
		"C",
		"D",
		"E",
		"F",
		"G",
		"H",
		"I",
		"J",
		"K",
		"L",
		"M",
		"N",
		"O",
		"P",
		"Q",
		"R",
		"S",
		"T",
		"U",
		"V",
		"W",
		"X",
		"Y",
		"Z", -- * Numbers
		"0",
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9", -- * Special chars
		"!",
		"@",
		"#",
		"$",
		"%",
		"^",
		"&",
		"*",
		"(",
		")",
		"-",
		"_",
		"=",
		"+",
		"{",
		"}",
		"[",
		"]",
		":",
		";",
		"'",
		"<",
		">",
		",",
		".",
		"?",
		"/",
	}
	local ret = ""
	for i = 1, length, 1 do
		ret = ret .. chars[math.random(1, #chars)]
	end
	return ret
end
---@param table table The table to search.
---@param value any The value to check for in the table.
---@return boolean Exists Whether the value exists in the table.
local function contains(table, value)
	for _, v in ipairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

local businternal = {
	ids = {},
	messages = {},
}
---@class messageBus
local bus = {
	---@param idlen? number The length of the subscription point ID (default is 16).
	---@return table SubPoint A subscription point object with an ID and a method to retrieve messages.
	NewSubPoint = function(idlen)
		idlen = idlen or 16
		local id = idgen(idlen)
		businternal.ids[#businternal.ids + 1] = id
		local ret = {
			id = id,
			---@param type string|nil The type of message to retrieve ("broadcast" or nil).
			---@return any Content The content of the retrieved message or nil if none found.
			GetMsg = function(type)
				if type == nil then
					return(businternal.messages[id])
				elseif type == "broadcast" then
					return(businternal.messages["ALL"])
				end
			end,
		}
		return ret
	end,
	---@param id string The ID of the recipient subscription point.
	---@param content any The message content to send.
	SendMessage = function(id, content)
		if contains(businternal.ids, id) then
			businternal.messages[id] = content
		end
	end,
	---@param content any The content to broadcast to all subscription points.
	---@return table Broadcast An object with a position and a method to end the broadcast.
	Broadcast = function(content)
		businternal.messages["ALL"] = content
		return {
			--! ends all broadcastes
			EndBroadcast = function()
				businternal.messages["ALL"] = nil
			end
		}
	end,
}

return bus
