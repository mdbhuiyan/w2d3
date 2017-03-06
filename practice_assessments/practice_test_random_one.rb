require "byebug"

# Write a recursive method that returns all of the permutations of an array
def permutations(array)
  return [] if array.nil?
  return [array] if array.length == 1
  perms = []
  array.each_with_index do |el, idx|
    test_array = array.dup
    test_array.delete_at(idx)

    perms += permutations(test_array).map { |p| p.unshift(el) }
  end

  perms
end

class Array

  def my_reverse
    return self if self.length == 1
    self[1..-1].my_reverse << self[0]
  end

end

# Write a method that translates a sentence into pig latin. You may want a helper method.
# 'apple' => 'appleay'
# 'pearl' => 'earlpay'
# 'quick' => 'ickquay'
def pig_latinify(sentence)
  final_sentence = []
  sentence.split(" ").each do |word|
    final_sentence << pig_word(word)
  end
  final_sentence.join(" ")
end

def pig_word(word)
  letters = word.downcase.split("")
  if letters[0] =~ /[aeiou]/
    return "#{word}ay"
  elsif letters[0..1].join =~ /ch/
    return "#{letters[2..-1].join}chay"
  elsif letters[0..2].join =~ /sch/
    return "#{letters[3..-1].join}schay"
  elsif letters[0..1].join =~ /qu/
    return "#{letters[2..-1].join}quay"
  elsif letters[0..2].join =~ /squ/
    return "#{letters[3..-1].join}squay"
  else
    i = 0
    until letters[i] =~ /[aeiou]/
      i += 1
    end
    return "#{letters[i..-1].join}#{letters[0..i-1].join}ay"
  end
end

class Hash

  # Write a version of my each that calls a proc on each key, value pair
  def my_each(&prc)
    i = 0
    keys = self.keys

    while i < self.keys.length
      prc.call(keys[i], self[keys[i]])
      i += 1
    end

  end

end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  alphabet ||= ("a".."z").to_a
  letters = str.split("")
  ordered_word = ""

  alphabet.each do |alpha|
    until ordered_word.split("").count(alpha) == letters.count(alpha)
      ordered_word += alpha
    end
  end
  return ordered_word
end
