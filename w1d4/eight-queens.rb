require 'byebug'

def n_queens_problem(n = 8)
  board = setup_board(n)
  number_of_placed_queens = 0

  until number_of_placed_queens == n
    board = place_queen(board)
    number_of_placed_queens += 1
  end

  display(board)
end

def place_board(board)
  flag = false

  until flag
    x = (0..n).to_a.sample
    y = (0..n).to_a.sample

    if board[x][y] != "queen" && board

def setup_board(n)
  Array.new(n) { Array.new(n) { [] } }
end



n_queens_problem
