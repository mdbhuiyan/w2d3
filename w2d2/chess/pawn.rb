require_relative "pieces"

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
