require "deck"
require "byebug"

describe Deck do
  subject(:deck) { Deck.setup_deck }
  let(:card) { double("card") }

  context "#initialize" do
    it "factory method Deck::all_cards initializes with all 52 cards" do
      expect(Deck.all_cards.length).to eq(52)
    end

    it "factory method Deck::setup_deck creates a new Deck object" do
      expect(Deck.setup_deck).to be_a(Deck)
    end

    it "can keep track of discarded cards separate from main deck" do
      deck.discard << card
      expect(deck.discard.length).to eq(1)
    end
  end

  context "#shuffle" do
    it "can shuffle the cards" do
      cards = deck.draw_pile.dup
      deck.shuffle
      expect(deck.draw_pile).not_to eq(cards)
    end
  end

  context "#draw" do
    it "can draw any number of cards from the top of the deck" do
      drawn_cards = deck.draw_pile[0..9]
      expect(deck.draw(10)).to eq(drawn_cards)
    end
  end

  context "#reset" do
    it "can shuffle when the round over and puts all discard back to deck" do
      deck.discard += deck.draw_pile.take(10)
      deck.reset
      expect(deck.discard.length).to eq(0)
      end
    end

  context "#receive_discard" do
    it "takes card and puts it in the discard pile" do
      deck.receive_discard(card)
      expect(deck.discard)
    end
  end

end
