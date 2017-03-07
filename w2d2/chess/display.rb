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
    board.grid.each do |row|
      puts "| " + row.join(" | ") + " |"
      puts "----" * 8 + "-"
    end
  end

  def test_render
    loop do
      render
      cursor.get_input
    end
  end

end
