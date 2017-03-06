class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def setup(board)

  end

  def get_guess(board)
    guess = []
    until valid_guess?(guess, board)
      puts "Enter row:"
      row = gets.chomp.to_i
      puts "Enter column:"
      col = gets.chomp.to_i
      guess = [row, col]
    end
    guess
  end

  def valid_guess?(guess, board)
    guess.length == 2 && guess.all? {|g| g < board.grid.length}
  end

end

# class ComputerPlayer
#   attr_accessor :seen_positions, :unseen_positions
#   attr_reader :name
#
#   def initialize(name)
#     @name = name
#     @seen_positions = Hash.new { |hash, key| hash[key] = [] }
#     @unseen_positions = []
#   end
#
#   def setup(board)
#     board.grid.length.times do |x|
#       board.grid.length.times do |y|
#         unseen_positions << [x, y]
#       end
#     end
#   end
#
#   def get_guess(board)
#     #AI methods using @seen_positions hash will go here
#     if hash.values.any? { |positions| positions.length == 2 }
#       #finds the key that has a value of an array with two items, then
#       #figures out how to return one of those two items (position)
#     else
#       guess = unseen_positions.sample
#       seen_positions[board[guess].face_value] << guess
#       unseen_positions.delete(guess)
#       guess
#   end
# end
