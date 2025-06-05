require('defaults')
Controls = require('controls.main')
Graphics = require('graphics.main')

Rectangle = love.image.newImageData(32, 32)
Player = love.graphics.newImage(Rectangle)
CurrentKey = ''
Position = {
	x = 0,
	y = 0,
}
Settings = {}
SpeedPerPixels = 32
ElapsedFrames = 0
ElapsedTime = 0

local function createMovementFor(character)
	local movement = {
		SpeedPerPixels * -1, -- UP, LEFT NEGATIVE
		0,
		SpeedPerPixels -- DOWN, RIGHT POSITIVE
	}
	local minXDistance = character.x - SpeedPerPixels < 0 and 2 or 1
	local maxXDistance = character.x + SpeedPerPixels > love.graphics.getWidth() and 2 or 3
	local minYDistance = character.y - SpeedPerPixels < 0 and 2 or 1
	local maxYDistance = character.y + SpeedPerPixels > love.graphics.getHeight() and 2 or 3
	local randX = math.random(minXDistance, maxXDistance)
	local randY = math.random(minYDistance, maxYDistance)
	CPOSX = CPOSX + movement[randX]
	CPOSY = CPOSY + movement[randY]
	print(randX, randY, CPOSX, CPOSY)
end

function love.load()
	DISTANCE = false
	CPOSX = 0
	CPOSY = 0
	Settings.controls = {
		UP='w',
		RIGHT='d',
		DOWN='s',
		LEFT='a',
		CHANGE_COLOR='c'
	}
    love.window.updateMode(800, 640, {
        fullscreen = false
    })
	Player:replacePixels(Graphics.recolorImagedata(Rectangle, 255))
    love.graphics.setBackgroundColor(60/255,0,80/255,1)
	local raw_data = ''
	for x=1,SpeedPerPixels do
		for y=1,SpeedPerPixels do
			raw_data =  raw_data..'1111'
		end
	end
	Character = love.image.newImageData(32, 32, "rgba8", raw_data)
end

function love.update(dt)
	FPS = 60
    ElapsedFrames = ElapsedFrames + 1
	local isSecond = math.fmod(ElapsedFrames, FPS) == 0
	ElapsedTime = isSecond
		and ElapsedTime + 1
		or ElapsedTime

	if isSecond then
		createMovementFor(C.pos)
	end

	if CPOSX ~= 0 then
		local normalized = CPOSX > 0 and -1 or 1
		C.pos.x = C.pos.x + (normalized * -1)
		CPOSX = CPOSX + normalized
	end
	if CPOSY ~= 0 then
		local normalized = CPOSY > 0 and -1 or 1
		C.pos.y = C.pos.y + (normalized * -1)
		CPOSY = CPOSY + normalized
	end
end

function love.keypressed(key)
	CurrentKey= key
	Controls.mechanics(key, Settings, Player, Rectangle)
    Controls.movements(key, Settings, Position, SpeedPerPixels)
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 and CPOSX == 0 and CPOSY == 0 then
		if (x == C.pos.x or x <= C.pos.x + SpeedPerPixels) and (y == C.pos.y or y <= C.pos.y + SpeedPerPixels) then
			createMovementFor(C.pos)
		end
	end
end



C = {
	pos = {
		x = 128,
		y = 128
	}
}

function love.draw()
	local offset_value = SpeedPerPixels * 2
	local offset_positions = {
		x = Position.x + offset_value >= love.graphics.getWidth() and Position.x - offset_value or Position.x + offset_value,
		y = Position.y + offset_value >= love.graphics.getHeight() and Position.y - offset_value or Position.y + offset_value,
	}
    love.graphics.print(("Current Key: %s\nElapsed time: %d(s)"):format(CurrentKey, ElapsedTime), offset_positions.x, offset_positions.y)
    love.graphics.draw(Player, Position.x, Position.y)

	local other = love.graphics.newImage(Character)
	other:replacePixels(Graphics.recolorImagedata(Character, {r=255,g=30,b=50}))
	love.graphics.draw(other, C.pos.x, C.pos.y)
	love.graphics.print(CPOSX, 32, 32)
	love.graphics.print(CPOSY, 64, 32)
	love.graphics.print(C.pos.x, 256, 32)
	love.graphics.print(C.pos.y, 288, 32)
end