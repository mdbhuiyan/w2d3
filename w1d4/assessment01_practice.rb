require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

def my_inject(accumulator = nil, &blk)
  debugger
  accumulator == [self[0]] if accumulator.nil?
  self[1..-1].each do |el|
    result = blk.call(el)
    accumulator += [result] unless el == accumulator
  end
end
  accumulator
end #class end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return true if num < 3 && num > 0
  (2..num / 2).to_a.each do |n|
    return false if num % n == 0
  end
  true
end

def primes(num)
  primes = []
  i = 2
  until primes.length == num
    primes << i if is_prime?(i)
    i += 1
  end
  primes
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  return [1, 1] if num == 2

  previous_factorials = factorials_rec(num - 1)
  previous_factorials + [(num - 1) * previous_factorials[-1]]
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    duplicates = {}

    self.each_with_index do |el, idx|
      if duplicates.keys.include?(el)
        duplicates[el] << idx
      else
        duplicates[el] = [idx]
      end
    end

    duplicates.reject { |key, value| value.length < 2}
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    subs = []
    letters = self.split(//)
    letters.each_index do |i|
      n = i
      while n < letters.length
        substring = letters[i..n].join("")
        subs << substring if substring.length > 1
        n += 1
      end
    end
    subs.reject {|substring| substring != substring.reverse}
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)

    prc ||= Proc.new { |x, y| x <=> y }
    return self unless self.is_a?(Array)
    return self if self.length <= 1

    if self.length > 2
      pivot = self.length / 2
      left_side = self[0..pivot]
      right_side = self[(pivot + 1)..-1]
      left = left_side.merge_sort(&prc)
      right = right_side.merge_sort(&prc)

    else
      left = [self[0]]
      right = [self[1]]
    end

    Array.merge(left, right, &prc)

  end

  private
  def self.merge(left, right, &prc)
    combined_array = []
    left || left = []
    right || right = []

    until left.empty? || right.empty?
      if prc.call(left[0], right[0]) == -1
        combined_array << left.shift
      else
        combined_array << right.shift
      end
    end

    combined_array += left if right.empty?
    combined_array += right if left.empty?

    combined_array
  end
end
