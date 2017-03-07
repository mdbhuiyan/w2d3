require_relative "display"
require_relative "pieces"
require "byebug"

class Board
  attr_accessor :grid
  attr_reader :display

  def initialize(board = nil)
    board ||= setup_board
    @grid = board
    @display = Display.new(self)
  end

  def setup_board
    initial_grid = Array.new(8) { Array.new(8) }

    final_grid = []

    initial_grid.each_with_index do |row, x|
      final_row = []
      row.each_with_index do |col, y|

        final_row << Piece.new([x, y], :blue, self) if x < 2
        final_row << Piece.new([x, y], :green, self) if x > 5
        final_row << NullPiece.new([x,y], self) if x > 1 && x < 6
      end
      final_grid << final_row
    end

    final_grid
  end

  def move_pos(start_pos, end_pos)
    if self[start_pos].is_a?(Piece) && self[end_pos].is_a?(NullPiece)
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    else
      #implement error handling here
    end
  end

  def [](pos)
    row, col = pos
    self.grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    self.grid[row][col] = value
  end
  #
  # def valid_move?(start, end, piece)
  #
  # end

  def in_bounds?(pos)
    row, col = pos
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7
    true
  end

end # end of Board class

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.display.test_render

end
