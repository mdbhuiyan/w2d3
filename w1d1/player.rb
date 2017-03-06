class Player
  attr_accessor :name, :losses

  GHOST = "GHOST"

  def initialize(name)
    @name = name
    @losses = 0
  end

  def score
    return "" if @losses == 0
    GHOST[0..@losses - 1]
  end

  def guess(fragment)
    display(fragment)
    puts "#{@name}, enter a letter:"
    guess = gets.chomp
    "#{fragment}#{guess}"
  end

  def alert_invalid_guess
    puts "You are bad, #{@name}! That was wrong!"
  end

  def display(fragment)
    print "The word so far:\n#{fragment}\n"
  end

end # end class
