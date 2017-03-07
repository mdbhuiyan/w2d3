require_relative "display"
require_relative "pieces"
require "byebug"

class Board
  attr_accessor :grid, :null
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
        final_row << Queen.new([x, y], :blue, self) if x < 2
        final_row << King.new([x, y], :green, self) if x > 5
        final_row << NullPiece.instance if x > 1 && x < 6
      end
      final_grid << final_row
    end

    final_grid
  end

  def move_pos(start_pos, end_pos)
    unless self[start_pos].is_a?(NullPiece) ||
      !self[start_pos].find_moves.include?(end_pos)
        if self[end_pos].is_a?(NullPiece)
          self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
          self[end_pos].position = end_pos
        else
          take_piece(start_pos, end_pos)
        end
    else
      puts "Not a valid move"
    end
  end

  def take_piece(start_pos, end_pos)
    victor = self[start_pos]
    loser = self[end_pos]
    self[end_pos] = victor
    victor.position = end_pos
    loser.position = nil
    self[start_pos] = NullPiece.instance
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
  # queen = Queen.new([4,4], :green, board)
  # bishop = Bishop.new([4, 4], :green, board)
  # rook = Rook.new([4,4], :green, board)
  # king = King.new([3,3], :blue, board)
  # pawn = Pawn.new([1,0], :blue, board)
  # board[[2,1]] = Rook.new([2,1], :green, board)
  #
  # puts pawn.find_moves.to_s
  # puts queen.find_moves.to_s
  # puts bishop.find_moves.to_s
  # puts rook.find_moves.to_s
  # puts king.find_moves.to_s

    board.display.test_render
end
