---Least common multiple
---@param a number
---@param b number
local function lcm(a, b)
	local aHolder, bHolder = a, b
	while aHolder ~= bHolder do
		if aHolder > bHolder then
			bHolder = bHolder + b
		else
			aHolder = aHolder + a
		end
	end
	return aHolder
end

---Prime factor of a given number.
---@param integer number
local function primeFactor(integer)
	local primeFactors = {}
	for i=0, integer, 1 do
		if math.fmod(integer, i) == 0 then
			primeFactors[#primeFactors+1] = i
		end
	end
	return primeFactors
end

---Greatest common divisor
---@param a number
---@param b number
local function gcd(a, b)
	return math.floor((a * b) / lcm(a, b))
end

return {
    LCM = lcm,
    GCD = gcd,
	PrimeFactor = primeFactor
}