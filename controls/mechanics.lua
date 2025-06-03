local graphics = require('graphics.main')

local function controlsMechanics(key, settings, drawableImage, imageData)
	if key == settings.controls.CHANGE_COLOR then
		graphics.redistributeRGB()
        drawableImage:replacePixels(graphics.recolorImagedata(imageData))
    end
end

return controlsMechanics