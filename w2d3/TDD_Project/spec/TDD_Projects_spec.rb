require "TDD_Projects"
describe "#my_uniq" do
  it 'call the remove all duplicate from the arary ' do
    expect([1, 2, 1, 3, 3].my_uniq).to eq([1, 2, 3])
  end


  it 'return a new array' do
    test_array = [1, 1, 1]
    expect(test_array.my_uniq).not_to be(test_array)
  end
end

 describe "#two_sum" do

  it "should return all pairs of indexes where elements sum to zero" do
    test_array = [1, 6, -1, 5, -5]
    expect(test_array.two_sum).to eq([[0, 2], [3, 4]])
  end

  it "returns array small first elments first, then smaller second elements first" do
    test_array = [5, -5, 0, 5, -5]
    expect(test_array.two_sum).to eq([[0, 1], [0, 4], [1, 3], [3, 4]])
  end
  it "return an emty array if no two sum to 0" do
    test_array= [1, 2, 3, 4]
    expect(test_array.two_sum).to eq([])
  end
 end

describe "#my_transpose" do
  it 'trasports rows and columns' do
    test_array = [
                [0, 1, 2],
                [3, 4, 5],
                [6, 7, 8]
              ]
    expect(test_array.my_transpose).to eq([
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ])
  end
  it 'return a new array' do
    test_array = [
                [0, 1, 2],
                [3, 4, 5],
                [6, 7, 8]
              ]
    expect(test_array.my_transpose).not_to be(test_array)

  end
end


describe "#stock_profit" do
  it "returns the biggest profit possible" do
    stocks = [10, 3, 1, 20]
    expect(stock_profit(stocks)).to eq([2, 3])
  end

  it "doesn't buy stock before selling" do
    stock = [10, 3, 20, 1]
    expect(stock_profit(stock)[0]).to be <(stock_profit(stock)[1])
  end
  it "return nil if profit <= 0" do
    stock = [5, 4, 3, 1]
    expect(stock_profit(stock)).to eq(nil)
  end
end


describe Game do
  subject(:game) {Game.new}
  describe "#initialize"do
  it "sets up 3 position" do
    expect(game.board.length).to eq(3)
  end
  it "start with 3 pices in position 1" do
    expect(game.board[0].length).to eq (3)
  end
end

  describe "#move" do
    it "moves piece to target position" do
      game.move(0, 1)
      expect(game.board[0].length).to eq (2)
      expect(game.board[1].length).to eq(1)
    end

    it "doesn't allow bigger piece to put on top of smaller piece" do
      game.move(0, 1)
      expect{game.move(0,1)}.to raise_error(InvalidMove)
    end

    it "raise an error if it is try to move to an empty position" do
      expect{game.move(1, 2)}.to raise_error(InvalidMove)
    end
  end

  describe "won?" do
    it "returns true when all 3 pieces are at position 3" do
      game.board = [[], [], [1, 2, 3]]
      expect(game.won?).to be true
    end
  end
end
