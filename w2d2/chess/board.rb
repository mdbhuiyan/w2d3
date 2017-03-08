require_relative "display"
require_relative "queen"
require_relative "king"
require_relative "knight"
require_relative "pawn"
require_relative "rook"
require_relative "bishop"
require_relative "nullpiece"

require "byebug"

class Board
  attr_accessor :grid, :null
  attr_reader :display

  def initialize(board_file = "standard_setup.txt")
    @grid = board_from_file(board_file)
    @display = Display.new(self)
  end

  def board_from_file(filename)
    lines = File.readlines(filename) if filename.is_a?(String)
    lines = filename if filename.is_a?(Array)
    final_grid = []

    lines.each_with_index do |line, row_pos|
      final_row = []
      line.split("").each_with_index do |char, col_pos|

        case char.to_sym
        when :R
          final_row << Rook.new([row_pos, col_pos], :blue, self)
        when :H
          final_row << Knight.new([row_pos, col_pos], :blue, self)
        when :B
          final_row << Bishop.new([row_pos, col_pos], :blue, self)
        when :K
          final_row << King.new([row_pos, col_pos], :blue, self)
        when :Q
          final_row << Queen.new([row_pos, col_pos], :blue, self)
        when :P
          final_row << Pawn.new([row_pos, col_pos], :blue, self)
        when :r
          final_row << Rook.new([row_pos, col_pos], :green, self)
        when :h
          final_row << Knight.new([row_pos, col_pos], :green, self)
        when :b
          final_row << Bishop.new([row_pos, col_pos], :green, self)
        when :k
          final_row << King.new([row_pos, col_pos], :green, self)
        when :q
          final_row << Queen.new([row_pos, col_pos], :green, self)
        when :p
          final_row << Pawn.new([row_pos, col_pos], :green, self)
        when :O
          final_row << NullPiece.instance
        end
      end
      final_grid << final_row
    end

    final_grid
  end

  def move_pos(start_pos, end_pos)
    unless self[start_pos].is_a?(NullPiece) ||
      !self[start_pos].valid_moves.include?(end_pos)
        if self[end_pos].is_a?(NullPiece)
          self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
          self[end_pos].position = end_pos
        else
          take_piece(start_pos, end_pos)
        end
    else
      puts "Not a valid move"
    end
  end

  def move_pos!(start_pos, end_pos)
    unless self[start_pos].is_a?(NullPiece) ||
      !self[start_pos].find_moves.include?(end_pos)
        if self[end_pos].is_a?(NullPiece)
          self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
          self[end_pos].position = end_pos
        else
          take_piece(start_pos, end_pos)
        end
    else
      puts "Not a valid move"
    end
  end

  def take_piece(start_pos, end_pos)
    victor = self[start_pos]
    loser = self[end_pos]
    self[end_pos] = victor
    victor.position = end_pos
    loser.position = nil
    self[start_pos] = NullPiece.instance
  end

  def find_king_position(color)
    self.grid.each do |row|
      row.each do |tile|
        if tile.is_a?(King) && tile.color == color
          return tile.position
        end
      end
    end
  end

  def find_all_team(color)
    team = []
    self.grid.each do |row|
      row.each do |tile|
        if tile.color == color
          team << tile
        end
      end
    end
    team
  end

  def in_check?(color)
    color == :blue ? opponent_color = :green : opponent_color = :blue
    king_position = find_king_position(color)
    enemy_pieces = find_all_team(opponent_color)

    enemy_pieces.each do |piece|
      return true if piece.find_moves.include?(king_position)
    end

    false
  end

  def checkmate?(color)
    return false unless in_check?(color)
    team = find_all_team(color)
    safe_moves = []
    team.each { |piece| safe_moves += piece.valid_moves }
    safe_moves.empty?
  end

  def [](pos)
    row, col = pos
    self.grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    self.grid[row][col] = value
  end
  #
  # def valid_move?(start, end, piece)
  #
  # end

  def in_bounds?(pos)
    row, col = pos
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7
    true
  end

  def stringify_board
    board_string = []
    grid.each do |row|
      row_string = ""
      row.each do |tile|
        if tile.is_a?(NullPiece)
          row_string += "O"
        else
          color = tile.color
          symbol = tile.symbol.to_s if color == :blue
          symbol = tile.symbol.to_s.downcase if color == :green
          row_string += symbol
        end
      end
      board_string << row_string
    end
    board_string
  end

  def duplicate_board
    Board.new(stringify_board)
  end

end # end of Board class

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  # queen = Queen.new([4,4], :green, board)
  # bishop = Bishop.new([4, 4], :green, board)
  # rook = Rook.new([4,4], :green, board)
  # king = King.new([3,3], :blue, board)
  # pawn = Pawn.new([1,0], :blue, board)
  # board[[2,1]] = Rook.new([2,1], :green, board)
  #
  # puts pawn.find_moves.to_s
  # puts queen.find_moves.to_s
  # puts bishop.find_moves.to_s
  # puts rook.find_moves.to_s
  # puts king.find_moves.to_s

    board.display.test_render
end
