require_relative "board.rb"
require_relative "tile.rb"
require 'colorize'
require "byebug"

class Game
  attr_reader :board

  def initialize(filename)
    @board = Board.from_file(filename)

  end

  def play

    until board.solved? do
      board.render
      guess = get_guess
      until valid_guess?(guess)
        puts "Please put in a valid guess"
        guess = get_guess
      end
      set_guess(guess)
    end
    puts "YOU WIN!!"

  end

  def get_guess

    puts "What row"
    row = gets.chomp.to_i
    puts "What col"
    col = gets.chomp.to_i
    puts "What value"
    value = gets.chomp.to_i
    pos = [row,col]

    [pos, value]

  end

  def set_guess(guess)
    pos, value = guess
    board[pos] = value
  end

  def valid_guess?(guess)
    pos, value = guess
    board[pos] == 0
  end
end

Game.new("sudoku1-almost.txt").play
