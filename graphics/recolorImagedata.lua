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

return recolorImagedata