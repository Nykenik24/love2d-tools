---@diagnostic disable: duplicate-set-field

function love.load()
	-- set font (MesloLG Nerd Font)
	local font = love.graphics.newFont("tests/assets/font.ttf")
	love.graphics.setFont(font)

	-- make images scale without blurring
	love.graphics.setDefaultFilter("nearest", "nearest")

	--logger
	LOGGER = require("modules.logger")
	LOGGER.init()
	LOGGER.startSVC()

	LOGGER.info("Started")

	--Replace with the test you want to run
	local test_path = "tests.vec2.test"
	TEST = require(test_path)
	TEST.load()

	MOUSE_GRABBED = true
end

function love.update(dt)
	love.mouse.setGrabbed(MOUSE_GRABBED)
	TEST.update(dt)
end

function love.draw()
	love.graphics.print("Enter: Unlock mouse from window", 0, love.graphics.getHeight() - 20)
	love.graphics.print("Escape: Quit", 0, love.graphics.getHeight() - 40)
	TEST.draw()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit(0)
	elseif key == "return" then
		MOUSE_GRABBED = not MOUSE_GRABBED
	end
end
