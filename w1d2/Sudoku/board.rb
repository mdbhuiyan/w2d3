require_relative "tile.rb"
require 'byebug'

class Board
  attr_accessor :grid

  def self.from_file(file_name)
    final_grid = []
    grid_lines = File.readlines(file_name).map(&:chomp)
    given = false
    grid_lines.each do |row|
      temp_grid = []
      row.split("").each do |digit|
        given = true if digit.to_i > 0
        given = false if digit.to_i == 0
        temp_grid << Tile.new(given, digit.to_i)
      end
      final_grid << temp_grid
    end

    Board.new(final_grid)
  end

  def initialize(grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col].value
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col].value = value
  end

  def render
    system("clear")
    9.times do |i|
      puts "" if i % 3 == 0
      print "#{i}  "
      9.times do |j|
        pos = [i, j]
        print "  " if j % 3 == 0
        print self[pos] == 0 ? " | _ | " : " | #{self.grid[i][j].to_s} | "
      end
    puts ""
    puts ""

    end
  end

  def solved?
    check_row(grid.transpose) && check_row(grid)
  end

  def check_row(grid)
    test_grid = grid.map { |row| row.map { |pos| pos.value }}
    test_grid.each do |row|
      (1..9).to_a.each do |digit|
        return false if row.count(digit) != 1
      end
    end
    true
  end

  def check_squares
    #we were in the middle of trying to figure out how to make this
    #check each square on the grid! Here's sort of what we were thinking:
    3.times do |i|
      3.times do |j|
        test_grid = grid[i].map { |pos| pos.value }
        first, second, third = test_grid.each_slice(3)
        array1 << first
        array2 << second
        array3 << third
      end
    end
    i + 3
  end


end

# board = Board.from_file('sudoku1.txt')
# board.render
