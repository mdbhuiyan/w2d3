require 'byebug'

class Array
  def my_inject(accumulator = nil, &prc)
    begin
      accumulator.nil? ? accumulator = self[0] : accumulator = prc.call(accumulator, self[0])
    rescue
      accumulator = [accumulator] if accumulator.is_a?(Array) == false
    end

    prc ||= Proc.new { |accumulator, el| accumulator += el }

    self[1..-1].each do |el|
      accumulator = prc.call(accumulator, el)
    end

    accumulator
  end
end

def is_prime?(num)
  return true if num == 2
  (2..(num/2)).to_a.each do |i|
    return false if num % i == 0
  end
  true
end

def primes(count)
  found_primes = []
  i = 2
  until found_primes.length == count
    found_primes << i if is_prime?(i)
    i += 1
  end

  found_primes
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.
def factorials_rec(num)
  return [1] if num == 1
  return [1, 1] if num == 2

  previous_factorials = factorials_rec(num - 1)
  previous_factorials << (previous_factorials[-1] * (num - 1))

  previous_factorials
end

class Array
  def dups
    duplicates = {}

    self.each.with_index do |el, idx|
      if duplicates.keys.include?(el)
        duplicates[el] << idx
      else
        duplicates[el] = [idx]
      end
    end

    duplicates.reject { |_, value| value.length < 2}
  end
end

class String
  def symmetric_substrings
    letters = self.split("")
    subs = []

    letters.each.with_index do |letter, idx|
      self.length.times do |idx2|
        subs << letters[idx..idx2].join("") if idx2 > idx
      end
    end

    subs.reject { |substring| substring != substring.reverse }
  end
end

class Array
  def merge_sort(&prc)

    
  end

  private
  def self.merge(left, right, &prc)
  end
end
