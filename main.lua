Rectangle = love.image.newImageData(32, 32)
Player = love.graphics.newImage(Rectangle)
CurrentKey = ''
Position = {
	x = 0,
	y = 0,
}
Settings = {}
SpeedPerPixels = 32
Color = {
	r=1,
	g=0,
	b=0,
}
ElapsedTime = 0

local ROUNDED_OFF = 0.999999

local function redistributeRGB()
	Color.r = Color.r + Color.g + Color.b
	Color.g = Color.r - (Color.g + Color.b)
	Color.b = Color.r - (Color.g + Color.b)
	Color.r = Color.r - (Color.g + Color.b)
end

local function recolorImagedata(imagedata, custom_color, x_range, y_range)
	local color_table = {
		custom_color == nil and Color.r or custom_color,
		custom_color == nil and Color.g or custom_color,
		custom_color == nil and Color.b or custom_color,
		1
	}
	x_range = x_range == nil and SpeedPerPixels - 1 or x_range
	y_range = y_range == nil and SpeedPerPixels - 1 or y_range
	for x = 0, x_range, 1 do
		for y = 0, y_range, 1 do
			imagedata:setPixel(x, y, color_table)
		end
	end
	return imagedata
end

local function controlsMovements()
	if CurrentKey == Settings.controls.UP then
        if Position.y - SpeedPerPixels < 0 then return end
        Position.y = Position.y - SpeedPerPixels
    end
	if CurrentKey == Settings.controls.RIGHT then
		if Position.x + SpeedPerPixels >= love.graphics.getWidth() then return end
		Position.x = Position.x + SpeedPerPixels
	end
    if CurrentKey == Settings.controls.DOWN then
        if Position.y + SpeedPerPixels >= love.graphics.getHeight() then return end
        Position.y = Position.y + SpeedPerPixels
    end
	if CurrentKey == Settings.controls.LEFT then
		if Position.x - SpeedPerPixels < 0 then return end
		Position.x = Position.x - SpeedPerPixels
	end
end

local function controlsMechanics()
	if CurrentKey == Settings.controls.CHANGE_COLOR then
		redistributeRGB()
        Player:replacePixels(recolorImagedata(Rectangle))
    end
end

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
	Player:replacePixels(recolorImagedata(Rectangle, 255))
    love.graphics.setBackgroundColor(80,0,80,1)
end

function love.update(dt)
    ElapsedTime = ElapsedTime + math.floor((SpeedPerPixels * dt) + ROUNDED_OFF)
    Movement = (SpeedPerPixels * dt) + ROUNDED_OFF
    
end

function love.keypressed(key)
    CurrentKey = key
	controlsMechanics()
    controlsMovements()
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