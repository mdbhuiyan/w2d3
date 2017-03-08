require_relative "card"
require 'byebug'
class Deck
  attr_accessor :draw_pile, :discard

  SUITS = [:hearts, :diamonds, :spades, :clubs]

  def initialize(starting_deck = Deck.all_cards)
    @draw_pile = starting_deck
    @discard = []
  end

  def self.setup_deck
    Deck.new(Deck.all_cards)
  end

  def self.all_cards
    all_cards = []

    SUITS.each do |suit|
      (2..14).to_a.each do |value|
        all_cards << Card.new(value, suit)
      end
    end

    all_cards
  end

  def shuffle
    draw_pile.shuffle!
  end

  def draw(num)
    drawn_cards = []
    num.times do
      drawn_cards << draw_pile.shift
    end

    drawn_cards
  end

  def reset
    self.draw_pile = Deck.all_cards
    self.discard = []
    shuffle
  end

  def receive_discard(card)
    @discard << card
  end

end
