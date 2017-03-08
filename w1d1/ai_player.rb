class AIPlayer
  attr_accessor :name, :losses

  GHOST = "GHOST"

  def initialize(name, number_of_players, dictionary)
    @name = name
    @number_of_players = number_of_players
    @dictionary = dictionary
    @losses = 0
  end

  def find_matching_words(fragment)
    matched_words = []
    @dictionary.each do |word|
      if word[0..(fragment.length - 1)] == fragment
        matched_words << word
      end
    end
    matched_words_two = []
    matched_words.each do |word|
      matched_words_two << word if word.length != fragment.length + 1
    end
    return matched_words_two if matched_words_two.length > 0
    matched_words
  end

  def filter_words(fragment, matched_words)
    filtered_words = []
    matched_words.each do |word|
      if word.length != fragment.length + @number_of_players
        filtered_words << word
      end
    end
    filtered_words
  end

  def guess(fragment)
    return ("a".."z").to_a.sample if fragment == ""
    matched_words = find_matching_words(fragment)
    possible_guesses = filter_words(fragment, matched_words)
    if possible_guesses.length > 0
      examined_words = []
      while examined_words.length < possible_guesses.length
        picked_word = possible_guesses.sample
        if ! test_word?(possible_guesses, picked_word) &&
          ! examined_words.include?(picked_word)
          examined_words << picked_word
        end
        break if test_word?(possible_guesses, picked_word)
      end
    else
      picked_word = matched_words.sample
    end
    picked_word[0..fragment.length]
  end

  def test_word?(possible_guesses, word)
    possible_guesses.each do |word|
      return false if word[0..word.length-1] == word
    end
    true
  end

  def score
    return "" if @losses == 0
    GHOST[0..@losses - 1]
  end

end #end of class
