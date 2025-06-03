local playerSprite = love.image.newImageData('/res/icon.png')
local player = love.graphics.newImage(playerSprite)
local r = 1
local g = 0
local b = 0
local ROUNDED_OFF = 0.999999
local elapsedTime = 0
local speedPerPixels = 32
local HEX_MAX = 256

function love.load()
    currentKey = ''
    position = {
        x = 0,
        y = 0,
    }
    love.window.updateMode(800, 640, {
        fullscreen = false
    })
    love.graphics.setBackgroundColor(80/HEX_MAX,0/HEX_MAX,80/HEX_MAX,1)
end

function love.update(dt)
    elapsedTime = elapsedTime + math.floor((speedPerPixels * dt) + ROUNDED_OFF)
    movement = (speedPerPixels * dt) + ROUNDED_OFF
    if love.keyboard.isDown("c") then
        local rectangle = love.image.newImageData(32, 32)
        r = r + g + b
        g = r - (g + b)
        b = r - (g + b)
        r = r - (g + b)
        for x = 0, 31, 1 do
            for y = 0, 31, 1 do
                rectangle:setPixel(x, y, {r, g, b, 1})
            end
        end
        player:replacePixels(rectangle)
    end
end

function love.keypressed(key)
    currentKey = key
    if key == 'w' then
        love.graphics.clear()
        if position.y - speedPerPixels < 0 then return end
        position.y = position.y - speedPerPixels
    end
    if key == 'a' then
        love.graphics.clear()
        if position.x - speedPerPixels < 0 then return end
        position.x = position.x - speedPerPixels
    end
    if key == 's' then
        love.graphics.clear()
        if position.y + speedPerPixels >= love.graphics.getHeight() then return end
        position.y = position.y + speedPerPixels
    end
    if key == 'd' then
        love.graphics.clear()
        if position.x + speedPerPixels >= love.graphics.getWidth() then return end
        position.x = position.x + speedPerPixels
    end
end

function love.draw()
    love.graphics.print(("Current Key: %s\nMovement: %d\nElapsed time: %d(s)"):format(currentKey, movement, elapsedTime), 100, 100)
    love.graphics.draw(player, position.x, position.y)
end