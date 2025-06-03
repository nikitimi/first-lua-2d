local playerSprite = love.image.newImageData('/res/icon.png')
local player = love.graphics.newImage(playerSprite)
local windowWidth = love.graphics.getWidth()
local windowHeight = love.graphics.getHeight()

function love.load()
    print(("Width: %d\nHeight: %d"):format(windowWidth, windowHeight))
end

function love.update(dt)
    if love.keyboard.isDown("c") then
        local rectangle = love.image.newImageData(32, 32)
        local t = table
        t:insert(0)
        t:insert(0)
        t:insert(1)
        t:insert(1)
        for x = 0, 31, 1 do
            for y = 0, 31, 1 do
                rectangle:setPixel(x, y, t)
            end
        end
        player:replacePixels(rectangle)
        print(dt)
    end
    if love.keyboard.isDown('w') then
        love.graphics.clear()
        love.graphics.draw(player, love.graphics.transformPoint(0, 1))   
    end
    if love.keyboard.isDown('a') then
        love.graphics.clear()
        love.graphics.draw(player, love.graphics.transformPoint(-1, 0))   
    end
    if love.keyboard.isDown('s') then
        love.graphics.clear()
        love.graphics.draw(player, love.graphics.transformPoint(0, -1))   
    end
    if love.keyboard.isDown('d') then
        love.graphics.clear()
        love.graphics.draw(player, love.graphics.transformPoint(1, 0))   
    end
end

function love.draw()
    love.graphics.draw(player)
end