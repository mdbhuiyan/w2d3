require_relative "steppable"
require_relative "pieces"

class King < Piece
  include SteppingPiece

  def initialize(position, color, board)
    super
    @allowed_deltas = []
    DIRECTIONS.values.each { |delta| @allowed_deltas << delta }
    @symbol = :K

  end

end # end of King class
