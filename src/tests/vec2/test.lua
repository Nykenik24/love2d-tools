---@diagnostic disable: duplicate-set-field
local test = {}
test.params = {
	bg_color = { 0.5, 0.5, 0.5 },
}

function test.load()
	MOUSE = require("modules.vec2")(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	CENTER = require("modules.vec2")(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

	MATHX = require("modules.math")

	SetColor = love.graphics.setColor
	TIME = 0
end

function test.update(dt)
	MOUSE:Translate(love.mouse.getPosition())
	MOUSE.angle = MATHX.AngleBetweenVectors(MOUSE, CENTER)

	DISTANCE = MATHX.DistanceBetweenVectors(MOUSE, CENTER)

	TIME = TIME + dt
	INFO_STRING = ([[
ANGLE: %f
CURSOR X: %i
CURSOR Y: %i
CENTER X: %i
CENTER Y: %i
DISTANCE: %f
CURSOR RELATIVE X: %i
CURSOR RELATIVE Y: %i

TIME ELAPSED: %i
]]):format(
		MOUSE.angle,
		MOUSE.x,
		MOUSE.y,
		CENTER.x,
		CENTER.y,
		DISTANCE,
		CENTER.x - DISTANCE,
		CENTER.y - DISTANCE,
		TIME
	)
end

function test.draw()
	SetColor(0.25, 0.75, 0.25, 1)
	MOUSE:Draw()

	SetColor(0.25, 0.25, 0.75, 1)
	love.graphics.circle("line", CENTER.x, CENTER.y, DISTANCE)

	--SetColor(0.75, 0.25, 0.25, 1)
	--love.graphics.rectangle("line", CENTER.x - DISTANCE, CENTER.y - DISTANCE, DISTANCE * 2, DISTANCE * 2)

	SetColor(0.4, 0.4, 0.4, 0.5)
	love.graphics.rectangle("fill", 0, 0, 200, 150)
	SetColor(1, 1, 1, 1)
	love.graphics.print(INFO_STRING, 0, 0, 0, 1)
end

return test
