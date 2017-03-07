require_relative "slideable"
require_relative "pieces"

class Rook < Piece
  include SlidingPiece

  def initialize(position, color, board)
    super
    @allowed_directions = [:N, :S, :E, :W]
    @symbol = :R
  end

end #end of Rook class
