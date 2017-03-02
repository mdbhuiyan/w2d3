require_relative 'card'
require_relative 'board'
require_relative 'player'
require "byebug"

class MatchTwo
  attr_accessor :previous_guess
  attr_reader :board, :player

  def initialize(player, grid_size = 4)
    @board = Board.new(grid_size)
    @player = player
  end

  def play
    board.populate

    player.setup(board)
    until board.won?
      board.render
      make_guess(player.get_guess(board))
    end
    board.render
    puts "You win"
  end

  def make_guess(guess)
    if previous_guess.nil?
      board.reveal(guess)
      self.previous_guess = guess
    else
      board.reveal(guess)
      if cards_match?(guess)
        puts "Match!"
      else
        puts "Cards do not match"
        board.render
        sleep(2)
        board[previous_guess].hide
        board[guess].hide
      end

      self.previous_guess = nil

    end

  end

  def cards_match?(guess)
    board[guess] == board[previous_guess]
  end

end

if __FILE__ == $PROGRAM_NAME
  MatchTwo.new(HumanPlayer.new("a")).play
end
