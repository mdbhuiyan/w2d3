require 'colorize'
require 'colorized_string'

class Tile
  attr_accessor :value, :given, :guessed_value

  def initialize(given, value)
    @value = value
    @given = given
  end

  def to_s
    given ? "#{value}".red : "#{value}"
  end
end
