require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos, :children

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    opponent_mark = :x if evaluator == :o
    opponent_mark = :o if evaluator == :x

    return false if board.winner == evaluator && board.over?
    return true if board.winner == opponent_mark && board.over?

    if next_mover_mark == evaluator

      children.each do |child|
        return false unless child.losing_node?(evaluator)
      end
      true
    elsif next_mover_mark == opponent_mark
      children.each do |child|
        return true if child.losing_node?(evaluator)
      end
      false
    end
  end

  def winning_node?(evaluator)
    opponent_mark = :x if evaluator == :o
    opponent_mark = :o if evaluator == :x

    return true if board.winner == evaluator && board.over?
    return false if board.winner == opponent_mark && board.over?

    if next_mover_mark == evaluator

      children.each do |child|
        return true if child.winning_node?(evaluator)
      end
      false
    elsif next_mover_mark == opponent_mark
      children.each do |child|
        return false unless child.winning_node?(evaluator)
      end
      true
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_nodes = []
    (0..2).to_a.each do |x|
      (0..2).to_a.each do |y|
        if board.empty?([x, y])
          position = [x, y]
          next_mark_child = :o if next_mover_mark == :x
          next_mark_child = :x if next_mover_mark == :o

          new_node = TicTacToeNode.new(board.dup, next_mark_child, position)
          new_node.board[position] = next_mover_mark

          child_nodes << new_node
        end
      end
    end
    child_nodes
  end

end #end of Node class
