local function movements(key, settings, position, defaultOffset)
	if key == settings.controls.UP then
        if position.y - defaultOffset < 0 then return end
        position.y = position.y - defaultOffset
    end
	if key == settings.controls.RIGHT then
		if position.x + defaultOffset >= love.graphics.getWidth() then return end
		position.x = position.x + defaultOffset
	end
    if key == settings.controls.DOWN then
        if position.y + defaultOffset >= love.graphics.getHeight() then return end
        position.y = position.y + defaultOffset
    end
	if key == settings.controls.LEFT then
		if position.x - defaultOffset < 0 then return end
		position.x = position.x - defaultOffset
	end
end

return movements