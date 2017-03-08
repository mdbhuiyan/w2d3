require "byebug"

class Board
  attr_accessor :cups
  attr_reader :name1, :name2

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { [] }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    cups.length.times do |i|
      cups[i] += [:stone, :stone, :stone, :stone] unless i == 6 || i == 13
    end
  end

  def valid_move?(start_pos)
    if start_pos < 1 || start_pos > 14
      raise InvalidStartingCup.new("Invalid starting cup")
    end
  end

  def make_move(start_pos, current_player_name)

    dont_place = 13 if current_player_name == name1
    dont_place = 6 if current_player_name == name2

    moving_stones = cups[start_pos]
    cups[start_pos] = []
    i = start_pos

    until moving_stones.empty?
      i += 1
      if i == 14
        i = 0
      end

      cups[i] << moving_stones.shift unless i == dont_place
    end

    render
    result = next_turn(i)
    result
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns

    case
    when ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    when cups[ending_cup_idx].length == 1
      :switch
    when cups[ending_cup_idx].length > 1
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    cups[0..5].none? { |cup| cup.length > 0 } ||
    cups[7..12].none? { |cup| cup.length > 0 }
  end

  def winner
    case cups[6] <=> cups[13]
    when 0
      :draw
    when -1
      name2
    when 1
      name1
    end

  end
end

class InvalidStartingCup < StandardError
end
