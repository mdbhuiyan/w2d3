require_relative 'tic_tac_toe_node'


class ComputerPlayer
  attr_reader :name

  def initialize
    @name = "Tandy 400"
  end

  def move(game, mark)
    winner_move(game, mark) || random_move(game)
  end

  private
  def winner_move(game, mark)
    (0..2).each do |row|
      (0..2).each do |col|
        board = game.board.dup
        pos = [row, col]

        next unless board.empty?(pos)
        board[pos] = mark

        return pos if board.winner == mark
      end
    end

    # no winning move
    nil
  end

  def random_move(game)
    board = game.board
    while true
      range = (0..2).to_a
      pos = [range.sample, range.sample]

      return pos if board.empty?(pos)
    end
  end
end


class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    not_losers = []
    winners = []

    current_node.children.each do |child|
      winners << child if child.winning_node?(mark)
      not_losers << child unless child.losing_node?(mark)
    end

    return winners.sample.prev_move_pos unless winners.empty?

    raise "No losers!" if not_losers.empty?
    not_losers.sample.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
