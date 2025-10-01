math.randomseed(os.time())
board = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
seperator = "|"

def setup()
    for i = 1,#board do
        print(board[i] .. seperator .. board[i])
    end
end