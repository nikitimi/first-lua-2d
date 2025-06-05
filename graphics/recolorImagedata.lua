local function recolorImagedata(imagedata, custom_color, x_range, y_range)
	local color_table = {
		r=custom_color == nil and Color.r or (type(custom_color) == 'table' and custom_color.r or custom_color),
		g=custom_color == nil and Color.g or (type(custom_color) == 'table' and custom_color.g or custom_color),
		b=custom_color == nil and Color.b or (type(custom_color) == 'table' and custom_color.b or custom_color),
	}
	x_range = x_range == nil and SpeedPerPixels - 1 or x_range
	y_range = y_range == nil and SpeedPerPixels - 1 or y_range
	for x = 0, x_range, 1 do
		for y = 0, y_range, 1 do
			imagedata:setPixel(x, y, color_table.r/255,color_table.g/255, color_table.b/255,1)
		end
	end
	return imagedata
end

return recolorImagedata