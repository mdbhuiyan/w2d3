require 'set'
require 'byebug'

class WordChainer

  ALPHABET = Array ("a".."z")

  attr_accessor :dictionary, :current_words, :all_seen_words

  def initialize(dictionary)
    @current_words = []
    @all_seen_words = []
    @dictionary = Set.new File.readlines(dictionary).map(&:chomp)
  end

  def adjacent_words(test_word)
    adjacents = []
    same_length_words = length_filter(test_word)

    test_letters = test_word.split("")

    same_length_words.each do |word|
      letters = word.split("")
      non_matches = 0
      letters.each_with_index do |letter, idx|
        non_matches += 1 if test_letters[idx] != letter
      end
      adjacents << word if non_matches == 1
    end
    adjacents
  end

  def length_filter(word)
    dictionary.reject { |string| string.length != word.length }
  end

  def run(original, target)
    current_words << original
    all_seen_words << original
    debugger
    until current_words.empty?
      new_current_words = []

      current_words.each do |current_word|
        adjacent_words(current_word).each do |adj_word|
          unless all_seen_words.include?(adj_word)
            new_current_words << adj_word
            all_seen_words << adj_word
          end
        end
      end
      puts current_words.to_s
      current_words = new_current_words
    end
  end

end

test_chain = WordChainer.new("dictionary.txt")
puts test_chain.run("duck", "ruby")
