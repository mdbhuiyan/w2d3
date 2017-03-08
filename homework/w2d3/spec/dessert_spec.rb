require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:cake) { Dessert.new("cake", 5, :chef) }
  let(:chef) { double("chef", name: "Matt") }

  describe "#initialize" do
    it "sets a type" do
      expect(cake.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(cake.quantity).to eq(5)
    end

    it "starts ingredients as an empty array" do
      expect(cake.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cake", "5", :chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      cake.add_ingredient("flour")
      expect(cake.ingredients).to include("flour")
    end
  end

  describe "#mix!" do
    before(:each) do
      cake.add_ingredient("sugar")
      cake.add_ingredient("flour")
      cake.add_ingredient("eggs")
      cake.add_ingredient("special sauce")
      cake.add_ingredient("vodka")
    end

    it "shuffles the ingredient array" do
      cake.mix!
      expect(cake.ingredients).not_to eql(["sugar", "flour", "eggs", "special sauce", "vodka"])
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      cake.eat(3)
      expect(cake.quantity).to eql(2)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { cake.eat(10)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Matt the Great Baker")
      expect(cake.serve).to eq("Chef Matt the Great Baker has made 5 cakes!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(cake)
      cake.make_more
    end
  end
end
