local board = {}
local player = "X"
local winner = nil
local cells = 200
local mode = nil
local score = 0

function love.load()
	love.window.setMode(600,600)
	resetBoard()
end

function resetBoard()
	board = {}
	for i = 1,3 do
		board[i] = {}
		for j = 1,3 do
			board[j] = {}
		end
	end
	player = "X"
	winner = nil
end


function love.draw()
    if not mode then
        -- Mode selection screen
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf("Choose Mode", 0, 100, 600, "center")
        love.graphics.printf("1. Player vs Player", 0, 250, 600, "center")
        love.graphics.printf("2. Player vs Computer", 0, 350, 600, "center")
        return
    end

    -- Draw grid
    love.graphics.setLineWidth(5)
    love.graphics.line(cellSize, 0, cellSize, 600)
    love.graphics.line(cellSize*2, 0, cellSize*2, 600)
    love.graphics.line(0, cellSize, 600, cellSize)
    love.graphics.line(0, cellSize*2, 600, cellSize*2)

    -- Draw marks
    love.graphics.setFont(love.graphics.newFont(80))
    for i = 1, 3 do
        for j = 1, 3 do
            local mark = board[i][j]
            if mark ~= "" then
                love.graphics.printf(mark, (j-1)*cellSize, (i-1)*cellSize + 40, cellSize, "center")
            end
        end
    end

    -- Draw winner text
    if winner then
        love.graphics.setFont(love.graphics.newFont(40))
        if winner == "Tie" then
            love.graphics.printf("It's a Tie!", 0, 610, 600, "center")
        else
            love.graphics.printf("Winner: " .. winner, 0, 610, 600, "center")
        end
        love.graphics.printf("Press R to Restart", 0, 560, 600, "center")
    else
        love.graphics.setFont(love.graphics.newFont(20))
        love.graphics.printf("Current Player: " .. currentPlayer, 0, 610, 600, "center")
    end
end

function love.keypressed(key)
    if not mode then
        if key == "1" then
            mode = "pvp"
        elseif key == "2" then
            mode = "cpu"
        end
    elseif key == "r" then
        resetBoard()
    end
end

function love.mousepressed(x, y, button)
    if button == 1 and not winner and mode then
        local row = math.floor(y / cellSize) + 1
        local col = math.floor(x / cellSize) + 1

        if row <= 3 and col <= 3 and board[row][col] == "" then
            board[row][col] = currentPlayer
            if checkWin(currentPlayer) then
                winner = currentPlayer
            elseif isFull() then
                winner = "Tie"
            else
                if currentPlayer == "X" then
                    currentPlayer = "O"
                else
                    currentPlayer = "X"
                end
            end

            -- If vs computer and it's computer's turn
            if mode == "cpu" and currentPlayer == "O" and not winner then
                computerMove()
            end
        end
    end
end

function computerMove()
    -- Simple AI: pick random empty cell
    local emptyCells = {}
    for i = 1, 3 do
        for j = 1, 3 do
            if board[i][j] == "" then
                table.insert(emptyCells, {i, j})
            end
        end
    end

    if #emptyCells > 0 then
        local move = emptyCells[math.random(#emptyCells)]
        board[move[1]][move[2]] = "O"
        if checkWin("O") then
            winner = "O"
        elseif isFull() then
            winner = "Tie"
        else
            currentPlayer = "X"
        end
    end
end

function checkWin(player)
    -- Rows and columns
    for i = 1, 3 do
        if board[i][1] == player and board[i][2] == player and board[i][3] == player then
            return true
        end
        if board[1][i] == player and board[2][i] == player and board[3][i] == player then
            return true
        end
    end
    -- Diagonals
    if board[1][1] == player and board[2][2] == player and board[3][3] == player then
        return true
    end
    if board[1][3] == player and board[2][2] == player and board[3][1] == player then
        return true
    end
    return false
end

function isFull()
    for i = 1, 3 do
        for j = 1, 3 do
            if board[i][j] == "" then
                return false
            end
        end
    end
    return true
end