class Tile
  attr_accessor :bomb, :reveal, :value, :flagged, :adjacents

  def initialize
    @bomb = false
    @reveal = false
    @value = 0
    @flagged = false
  end

  def hidden?
    reveal == false
  end

  def flagged?
    flagged == true
  end

  def to_s
    return "F" if flagged?
    return "*" if hidden?
    return "#" if bomb
    return "_" if value == 0
    value.to_s
  end

end
