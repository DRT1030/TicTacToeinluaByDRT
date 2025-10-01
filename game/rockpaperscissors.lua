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

local function getwinnerplayer(a,b)
   if a == b then
		return "Its a tie gng"
	elseif  
		(a == "rock" and b == "scissors")
		or (a == "paper" and b == "rock")
		or (a == "scissors" and b == "paper")
	then
		return "PLAYER 1 (ONE) WON!"
	else
		return "PLAYER 2 (TWO) WON!"
	end
end

print("Against (AI) or against another (player)?")
local answer = string.lower(io.read())

while true do
   if answer == "ai" then
      print("\nChoose rock, paper, or scissors (or type quit to exit)")
      local p = string.lower(io.read())
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
      elseif p =="ballz" then
         print("Vasectomy time!!")
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
   elseif answer == "player" then
      print("\nChoose rock, paper, or scissors (or type quit to exit)")
      local p = string.lower(io.read())
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
      elseif p =="ballz" then
         print("Vasectomy time!!")
         break
      end
      if not valid then
         state = "invalid"
      end
      print("\n\n\n\n\n\n\n\n\n\n\n\n\n\nNow player 2's turn")
      local p2 = string.lower(io.read())
      p2 = options[p2] or p2
      if p2 == "q" or p2 == "quit" then
         print("Quitting game...")
         break
      elseif p2 =="ballz" then
         print("Vasectomy time!!")
         break
      end
      

      if state ~= "invalid" then
         print("\n\nPlayer 1 chose (" .. p .. ") and Player 2 chose (" .. p2 .. ")")
         print(getwinnerplayer(p,p2))
      end
   else
      print("Again, that was incorrect")
   end
end
