require_relative 'tile'

class Board
  attr_reader :grid
  def initialize(grid_length = 9)
    @grid = Array.new(grid_length) { Array.new(grid_length) { Tile.new } }
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    grid[row][col] = val
  end

  def diffused?
    grid.each do |row|
      return false if row.any?{|tile| !(tile.bomb && tile.hidden?) }
    end
    true 
  end

  def populate
    populate_bombs
    grid.each_with_index do |row, x|
      row.each_with_index do |_, y|
        set_adjacents([x,y])
        set_value(self[[x,y]])
      end
    end

  end

  def set_adjacents(tile_position)
    x, y = tile_position
    adjacents_array = []

    [1, -1].each do |axis|
      x_axis_adj, y_axis_adj = [x + axis, y], [x, y + axis]
      adjacents_array << x_axis_adj if in_range?(x_axis_adj)
      adjacents_array << y_axis_adj if in_range?(y_axis_adj)
    end

    self[tile_position].adjacents = adjacents_array
  end

  def set_value(tile)
    adjacent_bombs = 0
    tile.adjacents.each do |adjacent|
      adjacent_bombs += 1 if self[adjacent].bomb
    end

    tile.value = adjacent_bombs
  end

  def in_range?(tile_position)
    x, y = tile_position
    (0...length).include?(x) && (0...length).include?(y)
  end

  def get_bomb_locations
    bomb_number = length ** 2 / 4
    bomb_locations = []

    bomb_number.times do
      bomb_locations << [rand(0..length - 1), rand(0..length - 1)]
    end

    bomb_locations
  end

  def length
    grid.length
  end

  def populate_bombs
    bomb_locations = get_bomb_locations
    bomb_locations.each do |bomb_location|
      self[bomb_location].bomb = true
    end
  end

  def render
    grid_top = "  | #{('0'..'8').to_a.join(' | ')}"
    puts grid_top
    divider = "-" * grid_top.length
    puts divider
    grid.each_with_index do |row, x|
      puts "#{x} | #{row.map(&:to_s).join(" | ")}"
    end
  end

end

b = Board.new
b.populate
b.render
