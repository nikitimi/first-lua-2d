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

function love.load()
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
    love.graphics.setBackgroundColor(80,0,80,1)
	
end


function love.update(dt)
	FPS = 60
    ElapsedFrames = ElapsedFrames + math.floor((FPS * dt) + ROUNDED_OFF)
	ElapsedTime = math.fmod(ElapsedFrames, FPS) == 0
		and ElapsedTime + 1
		or ElapsedTime
    Movement = (SpeedPerPixels * dt) + ROUNDED_OFF
end

function love.keypressed(key)
	Controls.mechanics(key, Settings, Player, Rectangle)
    Controls.movements(key, Settings, Position, SpeedPerPixels)
end

function love.draw()
	local offset_value = SpeedPerPixels * 2
	local offset_positions = {
		x = Position.x + offset_value >= love.graphics.getWidth() and Position.x - offset_value or Position.x + offset_value,
		y = Position.y + offset_value >= love.graphics.getHeight() and Position.y - offset_value or Position.y + offset_value,
	}
    love.graphics.print(("Current Key: %s\nElapsed time: %d(s)"):format(CurrentKey, ElapsedTime), offset_positions.x, offset_positions.y)
    love.graphics.draw(Player, Position.x, Position.y)
end