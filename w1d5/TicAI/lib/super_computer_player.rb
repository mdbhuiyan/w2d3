require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    not_losers = []

    current_node.children.each do |child|
      debugger
      return child.prev_move_pos if child.winning_node?(mark)
        not_losers << child if child.losing_node?(mark) == false
      end

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
