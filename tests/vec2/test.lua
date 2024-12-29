---@diagnostic disable: duplicate-set-field
local test = {}

function test.load()
	VECTOR = require("modules.vec2")(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	CENTER = require("modules.vec2")(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

	MATH = require("modules.math")

	love.mouse.setGrabbed(true)
	love.graphics.setDefaultFilter("nearest", "nearest")
	local font = love.graphics.newFont("tests/assets/font.ttf")
	love.graphics.setFont(font)

	SetColor = love.graphics.setColor
end

function test.update(dt)
	VECTOR:Translate(love.mouse.getPosition())
	VECTOR.angle = MATH.AngleBetweenVectors(VECTOR, CENTER)

	DISTANCE = MATH.DistanceBetweenVectors(VECTOR, CENTER)

	INFO_STRING = ([[
Angle: %f
VECTOR X: %i
VECTOR Y: %i
CENTER X: %i
CENTER Y: %i
DISTANCE: %f
VECTOR RELATIVE X: %i
VECTOR RELATIVE Y: %i
]]):format(VECTOR.angle, VECTOR.x, VECTOR.y, CENTER.x, CENTER.y, DISTANCE, CENTER.x - DISTANCE, CENTER.y - DISTANCE)
end

function test.draw()
	SetColor(0.25, 0.75, 0.25, 1)
	VECTOR:Draw()

	SetColor(0.25, 0.25, 0.75, 1)
	love.graphics.circle("line", CENTER.x, CENTER.y, DISTANCE)

	--SetColor(0.75, 0.25, 0.25, 1)
	--love.graphics.rectangle("line", CENTER.x - DISTANCE, CENTER.y - DISTANCE, DISTANCE * 2, DISTANCE * 2)

	SetColor(0.4, 0.4, 0.4, 0.5)
	love.graphics.rectangle("fill", 0, 0, 200, 125)
	SetColor(1, 1, 1, 1)
	love.graphics.print(INFO_STRING, 0, 0, 0, 1)
end

return test
