require "colorize"
require "byebug"

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @seq = [COLORS.sample]
    @sequence_length = 1
    @game_over = false
  end

  def play
    system("clear")
    puts "Let's play Simon Says! Watch the screen and repeat the colors in the same order"
    system("sleep 2")
    loop do
      result = take_turn
      break if game_over
      add_random_color
      round_success_message
    end
    game_over_message

    puts "Play again? (Y/N)"
    answer = gets.chomp
    reset_game if answer.upcase == "Y"
  end

  def take_turn
    show_sequence
    require_sequence
  end

  def show_sequence
    system("clear")
    seq.each do |color|
      puts color.colorize(color.to_sym)
      system("sleep 1")
      system("clear")
      system("sleep 1")
    end
  end

  def require_sequence
    seq.each_with_index do |color, idx|
      puts "Enter color ##{idx+1}: (R, B, G, Y)"
      guess = get_guess
      self.game_over = true unless guess == color
    end
  end

  def get_guess
    guess = gets.chomp
    case guess.upcase
    when "R"
      "red"
    when "Y"
      "yellow"
    when "G"
      "green"
    when "B"
      "blue"
    end
  end

  def add_random_color
    seq << COLORS.sample
    @sequence_length += 1
  end

  def round_success_message
    puts "You got all the colors correct! Adding a new color, get ready....."
    system("sleep 2")
  end

  def game_over_message
    puts "NO! THAT WAS NOT WHAT SIMON SAID. YOU LOSE, SIR OR MADAM, YOU LOSE!"
  end

  def reset_game
    self.seq = [COLORS.sample]
    self.sequence_length = 1
    self.game_over = false

    play
  end

end
