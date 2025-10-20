math.randomseed(os.time())
board = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
seperator = "|"

function setup()
    for i = 1,#board,3 do
        print(board[i] .. seperator .. board[i+1] .. seperator .. board[i+2])
    end
end

function reset()
    board = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
end


function isEmpty(n)
    return board[n] ~= "X" and board[n] ~= "O"
end

function getWinningMove(player) -- for the bot to pick your winning move
    -- Check rows
    for i = 1, 7, 3 do
        if board[i] == player and board[i+1] == player and isEmpty(i+2) then return i+2 end -- 1 2 checks 3
        if board[i] == player and board[i+2] == player and isEmpty(i+1) then return i+1 end -- 1 3 checks 2
        if board[i+1] == player and board[i+2] == player and isEmpty(i) then return i end -- 2 3 checks 1
    end
    -- Check columns
    for i = 1, 3 do
        if board[i] == player and board[i+3] == player and isEmpty(i+6) then return i+6 end -- 1 6 checks 3
        if board[i] == player and board[i+6] == player and isEmpty(i+3) then return i+3 end -- 1 9 checks 6
        if board[i+3] == player and board[i+6] == player and isEmpty(i) then return i end -- 3 9 checks 1
    end
    -- Check diagonals
    if board[1] == player and board[5] == player and isEmpty(9) then return 9 end -- 1 5 checks 9
    if board[1] == player and board[9] == player and isEmpty(5) then return 5 end -- 1 9 checks 5
    if board[5] == player and board[9] == player and isEmpty(1) then return 1 end -- 5 9 checks 1
    if board[3] == player and board[5] == player and isEmpty(7) then return 7 end -- 3 5 checks 7
    if board[3] == player and board[7] == player and isEmpty(5) then return 5 end -- 3 7 checks 5
    if board[5] == player and board[7] == player and isEmpty(3) then return 3 end -- 5 7 checks 3
    return nil
end

function boardcheck()
    for i = 1,9 do
        if board[i] ~= "X" and board[i] ~= "O" then
            return false
        end
    end
    return true
end

function getBlockingMove()
    return getWinningMove("X")  -- Block player's winning move by checking if its x
end

function getComputermove()
    local move = getWinningMove("O")
    if move then return move end
    move = getBlockingMove()
    if move then return move end
    if isEmpty(5) then 
        return 5 
    end

    local corners = {1, 3, 7, 9}
    for _, c in ipairs(corners) do
        if isEmpty(c) then return c end
    end
    
    local sides = {2, 4, 6, 8}
    for _, s in ipairs(sides) do
        if isEmpty(s) then return s end
    end

    return math.random(1,9)
end

function checkwin()
    -- Check rows
    for i = 1, 9, 3 do
        if board[i] ~= "" and board[i] == board[i+1] and board[i] == board[i+2] then
            if board[i] == "O" then
                return "comp"
            elseif board[i] == "X" then
                return "player"
            end
        end
    end

    -- Check columns
    for i = 1, 3 do
        if board[i] ~= "" and board[i] == board[i+3] and board[i] == board[i+6] then
            if board[i] == "O" then
                return "comp"
            elseif board[i] == "X" then
                return "player"
            end
        end
    end

    -- Check diagonals
    if board[1] ~= "" and board[1] == board[5] and board[1] == board[9] then
        if board[1] == "O" then
            return "comp"
        elseif board[1] == "X" then
            return "player"
        end
    end

    if board[3] ~= "" and board[3] == board[5] and board[3] == board[7] then
        if board[3] == "O" then
            return "comp"
        elseif board[3] == "X" then
            return "player"
        end
    end
end



while true do
    boardcheck()
    local winner = checkwin()
    if winner == "comp" then
        print("Computer won")
        reset()
    elseif winner == "player" then
        print("Player won")
        reset()
    end
    if boardcheck() == true then
        print("DRAW\n\n\n")
        reset()
    else
        setup()
        print("Welcome, please choose 1-9")
    local p1 = io.read("*line")
    if p1 == "q" then
        break
    end
    if tonumber(p1) and tonumber(p1) >= 1 and tonumber(p1) <= 9 and isEmpty(tonumber(p1)) then
        board[tonumber(p1)] = "X"
        local compMove = getComputermove()
        if compMove then
            board[compMove] = "O"
        end
    else
        print("Invalid move, try again.")
    end
end
    
end
