math.randomseed(os.time())

board = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

choices = { "rock", "paper", "scissors" }
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
   local state = nil
	if p == "q" or p == "quit" then
		break
	elseif p == "s" then
		p = "scissors"
	elseif p == "p" then
		p = "paper"
	elseif p == "r" then
		p = "rock"
	else
		state = "invalid"
	end
   if state ~= "invalid" then
      local c = computerchoice()
      print("\n\nYou chose " .. p .. "! \nThe computer chose " .. c .. "!\n")
      print(getwinner(p, c))
      print("\n\n\n\n")
   end
end
