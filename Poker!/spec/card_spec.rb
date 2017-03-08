require "card"

describe Card do
  subject(:card) { Card.new(8, :clubs) }
  context "it holds a value and a suit" do

    it "can report its value when asked" do
      expect(card.value).to eq(8)
    end

    it "can report its suit when asked" do
      expect(card.suit).to eq(:clubs)
    end

  end
end
