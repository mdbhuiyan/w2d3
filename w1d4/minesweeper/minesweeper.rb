class MineSweeper
  attr_accessor :board, :kaboom

  def initialize(grid_length = 9)
    @board = Board.new(grid_length)
    @kaboom = false
  end

  def run
    board.populate
    until over?
      play_turn
    end

    kaboom ? puts "BOOM! U R DEAD" : puts "YOU SURVIVED!"
  end

  def play_turn
    system("clear")
    board.render

  end

  def over?
    return true if kaboom || board.diffused?
    false
  end

  def valid_move?(move)

  end

  def get_move


  end

  def parse_move
    puts "Enter position and flag:"
    move = gets.chomp
    position, parameter = move.split(" ")
    position = position.split(",").map(&:to_i)

    [position, parameter]
  end


end
