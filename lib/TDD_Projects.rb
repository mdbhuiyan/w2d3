class Array
  def my_uniq
    sourt_array = []
    self.each do |el|
      sourt_array << el unless sourt_array.include?(el)
      end
      return sourt_array
  end

  def two_sum
    two_sums = []
    self.each_with_index do |el1, i|
      self.each_with_index do |el2, i2|
        if el1 + el2 == 0 && i != i2
          two_sums << [i, i2] unless two_sums.include?([i2, i])
        end
      end
    end
    two_sums
  end

  def my_transpose
    my_new_array = Array.new(self.length) {[]}
     self.length.times do |i|
       self.each do |row|
         my_new_array[i] << row[i]
       end
     end
    return my_new_array
  end
end

def stock_profit(array)
  profit_hash = {}

  array.each_with_index do |el1, i1|
    array.each_with_index do |el2, i2|
      unless i1 >= i2
        profit_hash[[i1, i2]] = el2 - el1
      end
    end
  end
  max_profit = profit_hash.max_by{|key, value| value }
  return nil if max_profit[1] <= 0
  max_profit[0]
end

class InvalidMove < StandardError
end

class Game
  attr_accessor :board
 def initialize
   @board = [[1, 2, 3], [], []]
 end

 def move(start, target)
  if board[start].empty?
    raise InvalidMove
  elsif board[target].length < 1 || board[start][0] < board[target][0]
     board[target].unshift(board[start].shift)
  else
     raise InvalidMove
  end
 end

 def won?
   return true if board[2].length == 3
   false
 end

end
