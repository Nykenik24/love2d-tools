---@diagnostic disable: duplicate-set-field

function love.load()
	--Replace with the test you want to run
	local test_path = "tests.vec2.test"
	TEST = require(test_path)
	TEST.load()
end

function love.update(dt)
	TEST.update(dt)
end

function love.draw()
	TEST.draw()
end
