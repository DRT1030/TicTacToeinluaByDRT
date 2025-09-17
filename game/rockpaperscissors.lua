-- IGNORE THIS ITS PERSONAL PROJECT

math.randomseed(os.time())

local choices = { "rock", "paper", "scissors" }
local function computerchoice()
	return choices[math.random(1, #choices)]
end

local function getwinner(p, c)
	if p == c then
		return "Its a tie gng"
	elseif
		(p == "rock" and c == "scissors")
		or (p == "paper" and c == "rock")
		or (p == "scissors" and c == "paper")
	then
		return "YOU WON!"
	else
		return "COMPUTER WON!"
	end
end

while true do
	print("\nChoose rock, paper, or scissors (or type quit to exit)")
	local p = io.read()
	p = string.lower(p)

   local options = {
      s = "scissors",
      p = "paper",
      r = "rock"
   }
   p = options[p] or p
   local state = nil


   local valid = false
   for _, i in ipairs(choices) do
      if p == i then
         valid = true
         break
      end
   end

	if p == "q" or p == "quit" then
		print("Quitting game...")
		break
	end
   
   if not valid then
      state = "invalid"
   end


   if state ~= "invalid" then
      local c = computerchoice()
      print("\n\nYou chose " .. p .. "! \nThe computer chose " .. c .. "!\n")
      print(getwinner(p, c))
      print("\n")
   end
end
