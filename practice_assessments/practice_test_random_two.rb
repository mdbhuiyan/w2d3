require "byebug"
# make better change problem from class
# make_better_change(24, [10,7,1]) should return [10,7,7]
# make change with the fewest number of coins

# To make_better_change, we only take one coin at a time and
# never rule out denominations that we've already used.
# This allows each coin to be available each time we get a new remainder.
# By iterating over the denominations and continuing to search
# for the best change, we assure that we test for 'non-greedy' uses
# of each denomination.

def make_better_change(value, coins)
  possible_combos = []
  return [] if value.nil?
  return [] if value < 1
  change = []
  coins.sort.reverse.each do |coin|
    temp_value = value
    if coin < temp_value
      temp_value -= coin
      temp_coin = []
      new_change = make_better_change(temp_value, coins.reject {|x| x > coin})
      possible_combos << [coin] + change
      temp_value -= new_change.inject(:+) unless new_change.empty?
    end
  end

  possible_combos.sort_by! { |x| x.length }.first
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  i = 1

  factors = []
  until i > num
    factors << i if num % i == 0
    i += 1
  end

  factors
end

# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  alphabet = ("a".."z").to_a

  coded_string = ""
  str.split("").each do |letter|
    if letter != " "
      current = alphabet.index(letter)
      mod = current + shift
      if mod >= alphabet.length || mod < 0

        new_letter = alphabet[(mod % alphabet.length)]
      else
        new_letter = alphabet[mod]
      end
    else
      coded_string += " "
    end
    coded_string ="#{coded_string}#{new_letter}"
  end

  coded_string
end

# Write a method that doubles each element in an array
def doubler(array)
  return [array[0] * 2] if array.length == 1
  [array[0] * 2] + doubler(array[1..-1])
end

class Array
  def bubble_sort!(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    sorted = false
    until sorted
      sorted = true
      i = 0

      while i < self.length - 1
        unless prc.call(self[i], self[i+1]) < 0
          self[i], self[i+1] = self[i+1], self[i]
          sorted = false
        end
        i += 1
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!
  end
end
