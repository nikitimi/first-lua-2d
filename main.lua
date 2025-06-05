HEX = 255
BASE__PIXEL = 32

--- Returns 256 values into 0 - 1 for RGBA.
---@param r number
---@param g number
---@param b number
---@param a number
---@return {[1]: number, [2]: number, [3]: number, [4]: number}
local function normalizeColors(r, g, b, a)
	return {r/HEX, g/HEX, b/HEX, a/HEX}
end

--- Fill the whole image data with basic color
---@param imageData love.ImageData
---@param r number
---@param g number
---@param b number
---@param a number|nil
local function fillCharacterBasis(imageData, r, g, b, a)
	local w, h = imageData:getDimensions()
	local alpha = HEX

	if type(a) == 'number' then
		alpha = a
	end

	for x=0, w-1 do
		for y=0, h-1 do
			imageData:setPixel(x, y, unpack(normalizeColors(r, g, b, alpha)))
		end
	end
	return imageData
end

--- Move the Drawing
---@param imageData love.Image
---@param coordinate 'x'|'y'
---@param value number
local function moveDrawing(imageData, coordinate, value)
	---@type {x: number, y: number, dx: number, dy: number}
	local imageDataCoordinates = Coordinates[imageData]
	if coordinate == 'x' then
		imageDataCoordinates.dx = imageDataCoordinates.dx + value
	else
		imageDataCoordinates.dy = imageDataCoordinates.dy + value
	end
end

--- Check if array has the value passed as value argument.
---@param list {[string]: number|string}
---@param value string
---@return boolean
local function insideTheList(list, value)
	for k, _ in pairs(list) do
		if k == value then
			return true
		end
	end
	return false
end

function love.load()
	local characterData = fillCharacterBasis(love.image.newImageData(BASE__PIXEL, BASE__PIXEL * 2), 255, 200, 0)
	Player = love.graphics.newImage(characterData)
	Player:setFilter("nearest", "nearest")

	Coordinates = {}
	Coordinates[Player] = {
		x = 0,
		y = 0,
		dx = 0,
		dy = 0,
	}

	Controls = {
		UP = 'w',
		LEFT = 'a',
		DOWN = 's',
		RIGHT = 'd',
	}
end

function love.update(dt)
	---@type {x: number, y: number, dx: number, dy: number}
	local playerCoordinates = Coordinates[Player]
	local movementBaseValue = 1
	if playerCoordinates.x ~= playerCoordinates.dx then
		local movement = playerCoordinates.x > playerCoordinates.dx and -movementBaseValue or movementBaseValue
		playerCoordinates.x = playerCoordinates.x + movement
	end
	if playerCoordinates.y ~= playerCoordinates.dy then
		local movement = playerCoordinates.y > playerCoordinates.dy and -movementBaseValue or movementBaseValue
		playerCoordinates.y = playerCoordinates.y + movement
	end
end

function love.draw()
	---@type {x:number, y:number, dx:number, dy:number}
	local playerCoordinates = Coordinates[Player]
	love.graphics.draw(Player, playerCoordinates.x, playerCoordinates.y, nil, 2, 2)
	love.graphics.print(
		('X: %d\tY: %d\tdX: %d\tdY: %d')
		:format(playerCoordinates.x, playerCoordinates.y,playerCoordinates.dx,playerCoordinates.dy), 
		320,
		320
	)
end

function love.keypressed(key)
	local keysWithMovements = {
		[Controls.UP]='y'..BASE__PIXEL*-1,
		[Controls.LEFT]='x'..BASE__PIXEL*-1,
		[Controls.DOWN]='y'..BASE__PIXEL,
		[Controls.RIGHT]='x'..BASE__PIXEL
	}
	if not insideTheList(keysWithMovements, key) then return end
	
	local control = keysWithMovements[key]
	---@type 'x'|'y'
	local coordinate = control:sub(1, 1)
	local value = tonumber(control:sub(2)) and tonumber(control:sub(2)) or 0
	moveDrawing(Player, coordinate, value)
end