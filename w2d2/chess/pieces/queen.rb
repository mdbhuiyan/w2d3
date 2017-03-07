require_relative "piece.rb"
require_relative "slideable"

class Queen < Piece
  include SlidingPiece

  def initialize(position, color, board)
    super
    @allowed_directions = DIRECTIONS.keys
    @symbol = :Q
  end

end #end of Queen class
