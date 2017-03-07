require "colorize"
require_relative "cursor"

class Display

  attr_reader :board, :cursor
  attr_accessor :cursor_pos

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @cursor_pos = @cursor.cursor_pos
  end

  def render
    system("clear")
    self.cursor_pos = cursor.cursor_pos
    puts "----" * 8 + "-"
    board.grid.each_with_index do |row_arr, row_pos|
      puts "| " + build_row(row_arr, row_pos) + " |"
      # puts "| " + row.join(" | ") + " |"
      puts "----" * 8 + "-"
    end
  end

  def build_row(row_arr, row_pos)
    result = []

    row_arr.each_with_index do |tile, col_pos|
      if [row_pos, col_pos] == self.cursor_pos
        result << tile.to_s.colorize(:background => :red)
      else
        result << tile.to_s
      end
    end

    result.join(" | ")
  end

  def test_render
    loop do
      render
      start_pos = nil
      until start_pos
        start_pos = cursor.get_input
        render
      end

      end_pos = nil
      until end_pos
        end_pos = cursor.get_input
        render
      end

      board.move_pos(start_pos, end_pos)
    end
  end

end
