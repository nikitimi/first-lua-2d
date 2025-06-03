local function redistributeRGB()
	Color.r = Color.r + Color.g + Color.b
	Color.g = Color.r - (Color.g + Color.b)
	Color.b = Color.r - (Color.g + Color.b)
	Color.r = Color.r - (Color.g + Color.b)
end

return redistributeRGB