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
  end

  def to_s
    if self.position == board.display.cursor_pos
      "#{self.symbol}".colorize(:red)
    else
      "#{self.symbol}".colorize(color)
    end
  end

end

class NullPiece < Piece

  def initialize(position, board)
    @position = position
    @board = board
  end

  def to_s
    if self.position == board.display.cursor_pos
      " ".colorize(:background => :red)
    else
      " "
    end
  end

end


module SteppingPiece

  def find_valid_moves
    valid_moves = []
    find_all_moves.each do |move|
      if board.in_bound?(move)
        if board[move].is_a?(NullPiece) || board[move].color != color
          valid_moves << move
        end
      end
    end
    valid_moves
  end

  def find_all_moves
    all_moves = []

    allowed_deltas.each do |delta|
      all_moves << [position[0] + delta[0], position[1] + delta[1]]
    end

    all_moves
  end
end

module SlidingPiece

  def find_valid_moves

    valid_moves = []
    all_moves = find_all_moves
    all_moves.values.each do |moves|
      slide_end = false
      moves.each do |move|

        if board[move].is_a?(NullPiece) && slide_end
          valid_moves << move
        else
          other_piece = board[move]
          if other_piece.color == self.color
            slide_end = true
          else
            valid_moves << move unless slide_end
            slide_end = true
          end

        end

      end

    end
    valid_moves
  end

  def find_all_moves
    all_moves = Hash.new { |h, k| h[k] = [position] }

    allowed_directions.each do |dir|
      delta = Piece::DIRECTIONS[dir]

      while board.in_bounds?(all_moves[dir].last)
        last_move = all_moves[dir].last
        new_move = [last_move[0] + delta[0], last_move[1] + delta[1]]
        all_moves[dir] << new_move
      end

      all_moves[dir].shift
      all_moves[dir].pop

    end
    all_moves
  end

end

class King < Piece
  include SteppingPiece

  def initialize(position, color, board)
    @allowed_deltas = []
    DIRECTIONS.values.each { |delta| @deltas << delta }
    @symbol = :K
    super
  end

end # end of King class

class Knight < Piece
  include SteppingPiece

  def initialize(position, color, board)
    @allowed_deltas = [
      [2, -1],
      [2, 1],
      [1, 2],
      [1, -2],
      [-2, -1],
      [-2, 1],
      [-1, 2],
      [-1, 2]
    ]
    @symbol = :H
    super
  end

end #end of Knight class

class Bishop < Piece
include SlidingPiece

  def initialize(position, color, board)
    @allowed_directions = [:NE, :NW, :SE, :SW]
    super
  end

end #end of Bishop class

class Rook < Piece
include SlidingPiece

  def initialize(position, color, board)
    @allowed_directions = [:N, :S, :E, :W]
    super
  end

end #end of Rook class

class Queen < Piece
include SlidingPiece

def initialize(position, color, board)
  @allowed_directions = DIRECTIONS.keys
  super
end

end #end of Queen class
