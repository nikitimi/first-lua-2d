local function normalizeColor(r, g, b, a)
	return {r/HEX, g/HEX, b/HEX, a/HEX}
end

function love.load()
	HEX = 255
	Cube = love.graphics.newImage('/res/icon.png')
	Cube:setFilter("nearest", "nearest")
end

function love.update(dt)
	
end

function love.draw()
	love.graphics.draw(Cube, 0, 0, nil, 16, 16)
end

function love.keypressed(key)
	if key == 'd' then
		local imageData = love.image.newImageData(2, 2, "rgba8", '0000000000000000')
		imageData:setPixel(0, 0, unpack(normalizeColor(250, 0, 20, 255)))
		imageData:setPixel(1, 0, unpack(normalizeColor(0, 250, 20, 255)))
		imageData:setPixel(0, 1, unpack(normalizeColor(0, 20, 250, 255)))
		imageData:setPixel(1, 1, unpack(normalizeColor(0, 100, 250, 255)))
		Cube:replacePixels(imageData)
	end
end