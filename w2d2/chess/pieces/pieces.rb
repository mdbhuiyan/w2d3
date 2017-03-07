class Piece

  attr_accessor :position, :allowed_deltas, :allowed_directions
  attr_reader :color, :board, :symbol

  DIRECTIONS = {
    :N => [-1, 0],
    :NE => [-1, 1],
    :E => [0, 1],
    :SE => [1, 1],
    :S => [1, 0],
    :SW => [1, -1],
    :W => [0, -1],
    :NW => [-1, -1]
  }

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @symbol = :P
  end

  def to_s
    "#{self.symbol}".colorize(color)
  end

  def enemy?(other_piece)
    return false if other_piece.is_a?(NullPiece)
    self.color != other_piece.color
  end

  def friend?(other_piece)
    return false if other_piece.is_a?(NullPiece)
    self.color == other_piece.color
  end

  def empty_space?(other_piece)
    other_piece.is_a?(NullPiece)
  end

  def move_into_check?(end_pos)
    dup_board = board.duplicate_board
    dup_board.move_pos(self.position, end_pos)
    dup_board.in_check?(self.color)
  end

  def valid_moves
    moves = self.find_moves
    moves.reject { |move| self.move_into_check?(move) }
  end

end #end of Piece class
