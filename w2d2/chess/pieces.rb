require "Singleton"

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

end #end of Piece class

class NullPiece < Piece
  include Singleton

  # def initialize(position, board)
  #   @position = position
  #   @board = board
  # end

  def initialize
    @symbol = " "
  end

  # def to_s
  #   if self.position == board.display.cursor_pos
  #     " ".colorize(:background => :red)
  #   else
  #     " "
  #   end
  # end

end

module SteppingPiece

  def find_moves
    valid_moves = []
    find_all_moves.each do |move|
      if board.in_bounds?(move)
        if self.empty_space?(board[move]) || self.enemy?(board[move])
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

  def who_goes_there(other_piece)
    return :empty if self.empty_space?(board[other_piece])
    return :enemy if self.enemy?(board[other_piece])
    return :friend if self.friend?(board[other_piece])
  end

  def find_moves
    valid_moves = Hash.new { |h, k| h[k] = [position] }

    allowed_directions.each do |dir|
      delta = Piece::DIRECTIONS[dir]

      flag = false
      until flag
        last_move = valid_moves[dir].last
        new_move = [last_move[0] + delta[0], last_move[1] + delta[1]]
        if board.in_bounds?(new_move)
          case who_goes_there(new_move)
          when :empty
            valid_moves[dir] << new_move
          when :enemy
            valid_moves[dir] << new_move
            flag = true
          when :friend
            flag = true
          end
        else
          flag = true
        end #end of board.in_bounds?
      end # end of until loop
    end # end of each loop

    parse_moves(valid_moves)
  end #end of method

  def parse_moves(valid_moves_hash)
    moves = []
    valid_moves_hash.values.each do |array|
      moves += array
    end

    moves.delete(position)
    moves
  end #end of method


end ## end SlidingPiece module

class King < Piece
  include SteppingPiece

  def initialize(position, color, board)
    super
    @allowed_deltas = []
    DIRECTIONS.values.each { |delta| @allowed_deltas << delta }
    @symbol = :K

  end

end # end of King class

class Knight < Piece
  include SteppingPiece

  def initialize(position, color, board)
      super
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

  end

end #end of Knight class

class Bishop < Piece
  include SlidingPiece

  def initialize(position, color, board)
    super
    @allowed_directions = [:NE, :NW, :SE, :SW]
    @symbol = :B
  end

end #end of Bishop class

class Rook < Piece
  include SlidingPiece

  def initialize(position, color, board)
    super
    @allowed_directions = [:N, :S, :E, :W]
    @symbol = :R
  end

end #end of Rook class

class Queen < Piece
  include SlidingPiece

  def initialize(position, color, board)
    super
    @allowed_directions = DIRECTIONS.keys
    @symbol = :Q
  end

end #end of Queen class

class Pawn < Piece

  attr_reader :starting_row, :facing

  def initialize(position, color, board)
    super
    @starting_row = position[0]
    @starting_row == 6 ? @facing = :up : @facing = :down
  end

  def find_moves
    moves = []
    moves << pawn_advance if board.in_bounds?(pawn_advance) &&
      self.empty_space?(board[pawn_advance])
    moves << pawn_advance_two if position[0] == starting_row &&
      self.empty_space?(board[pawn_advance]) &&
      self.empty_space?(board[pawn_advance_two])
    moves << diagonal_attack_left if self.enemy?(board[diagonal_attack_left])
    moves << diagonal_attack_right if self.enemy?(board[diagonal_attack_right])
    moves.reject { |move| move.empty? }
  end

  def pawn_advance
    move = [position[0] + 1, position[1]] if facing == :down
    move = [position[0] - 1, position[1]] if facing == :up
    return move if board.in_bounds?(move)
    self.position # returning current position so that #enemy? will not error
  end

  def pawn_advance_two
    return [position[0] + 2, position[1]] if facing == :down
    return [position[0] - 2, position[1]] if facing == :up
  end

  def diagonal_attack_left
    move = [position[0] + 1, position[1] - 1] if facing == :down
    move = [position[0] - 1, position[1] - 1] if facing == :up
    return move if board.in_bounds?(move)
    self.position # returning current position so that #enemy? will not error
  end

  def diagonal_attack_right
    move = [position[0] + 1, position[1] + 1] if facing == :down
    move = [position[0] - 1, position[1] + 1] if facing == :up
    return move if board.in_bounds?(move)
    self.position # returning current position so that #enemy? will not error
  end

end
