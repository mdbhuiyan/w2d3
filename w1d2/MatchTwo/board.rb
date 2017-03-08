require_relative 'card.rb'
require "byebug"

class Board

  attr_reader :grid

  def initialize(grid_size)
    @grid = Array.new(grid_size){Array.new(grid_size)}
  end

  def shuffle_cards
    cards = []
    2.times do
      ((self.grid.length**2)/2).times do |i|
        cards << Card.new(i)
      end
    end
    cards.shuffle
  end

  def populate
    cards = shuffle_cards
    card_index = 0

    grid.each_with_index do |row, row_index|
      row.each_index do |col|
        pos = [row_index, col]
        self[pos] = cards[card_index]
        card_index += 1
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def render
    system("clear")
    grid.length.times do |i|
      print "      #{i}"
    end
    puts ""
    row_marker = 0
    grid.each_with_index do |row, row_index|
      print "#{row_marker}"
      row.each_index do |col|
        pos = [row_index, col]
        print " | #{self[pos].to_s} | "
        end
      row_marker += 1
      puts ""
      puts ""
    end
  end

  def won?
    grid.flatten.all? { |card| card.face_up == true}
  end

  def reveal(guessed_pos)
    self[guessed_pos].reveal if self[guessed_pos].face_up == false
  end

end
#
# board = Board.new
# board.populate
# # puts board.grid
# board.render
