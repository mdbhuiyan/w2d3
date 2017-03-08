require_relative "slideable"
require_relative "pieces"

class Bishop < Piece
  include SlidingPiece

  def initialize(position, color, board)
    super
    @allowed_directions = [:NE, :NW, :SE, :SW]
    @symbol = :B
  end

end #end of Bishop class
