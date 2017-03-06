require_relative 'player'
require_relative 'ai_player'

class Ghost

  attr_accessor :current_player, :previous_player, :fragment, :players

  def initialize(dictionary)
    @fragment = ""
    @dictionary = File.readlines(dictionary).map(&:chomp)
  end

  def display_standings
    @players.each do |player|
        puts "#{player.name}: #{player.score}"
    end
  end

  def round_over?
    return true if @dictionary.include?(@fragment)
    false
  end

  def setup
    @players = []
    puts "How many human players?"
    human_num = gets.chomp.to_i
    human_num.times do |i|
      puts "Enter human player #{i + 1}"
      name = gets.chomp
      @players << Player.new(name)
    end
    puts "How many AI players?"
    ai_num = gets.chomp.to_i
    ai_num.times do |i|
      puts "Enter AI player #{i + 1}"
      name = gets.chomp
      @players << AIPlayer.new(name, ai_num + human_num, @dictionary)
    end
    @current_player = 0
  end

  def run
    setup
    until game_over?
      display_standings
      puts "Hit enter to start the next round!"
      gets
      play_round
      loser?
    end
      puts "#{@players[0].name} has won!"
  end

  def game_over?
    @players.length == 1
  end

  def loser?
    loser = nil
    @players.each.with_index do |player, index|
      loser = index if player.losses == 5
    end
    puts "#{@players[loser].name} has been eliminated!" if loser != nil
    @players.delete_at(loser) if loser != nil
  end

  def play_round
    until round_over?
      system('clear')
      take_turn(@players[@current_player])
      next_player!
    end
    puts "#{@fragment} is a word! Round over."
    @fragment = ""
    @players[@previous_player].losses += 1
  end

  def next_player!
    @previous_player = @current_player
    if @current_player + 1 == @players.length
      @current_player = 0
    else
      @current_player += 1
    end
  end

  def valid_play?(string)
    l = string.length - 1
    flag = false
    @dictionary.each do |word|
      flag = true if word[0..l] == string
    end
    flag
  end

  def take_turn(player)
    guess = ""
    loop do
      guess = player.guess(@fragment)
      if ! valid_play?(guess)
        player.alert_invalid_guess
      else
        break
      end
    end
    @fragment = guess
  end

end # end class

if __FILE__ == $PROGRAM_NAME
  game = Ghost.new("dictionary.txt")
  game.run
end
