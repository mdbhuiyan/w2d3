require_relative "steppable"
require_relative "pieces"

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
