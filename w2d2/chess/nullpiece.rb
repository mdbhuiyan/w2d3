require_relative "pieces"
require "singleton"

class NullPiece < Piece
  include Singleton

  def initialize
    @symbol = " "
  end

end
