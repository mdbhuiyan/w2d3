require_relative "node.rb"
require "byebug"

class KnightPathFinder
  attr_accessor :start_position, :root_node, :moves, :visited_positions

  DELTAS = [[2,1], [1,2], [2, -1], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]

  def initialize(start_position)
    @start_position = start_position
    @root_node = PolyTreeNode.new(start_position)
    @visited_positions = [start_position]
    build_move_tree
  end

  def build_move_tree
    que = [@root_node]
    until que.empty?
      node = que.shift
      child_moves = new_move_positions(node.value) # child moves

      child_moves.each do |child|
        child_node = PolyTreeNode.new(child)
        node.add_child(child_node)
        que << child_node
      end
    end
  end

  def self.valid_moves(pos)
    p1, p2 = pos
    moves = []

    DELTAS.each do |delta|
      moves << [p1 + delta[0], p2 + delta[1]]
    end

    moves.reject! { |move| move.first < 0 || move.last < 0 }
    moves.reject! { |move| move.first > 7 || move.last > 7 }

    moves
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves.reject! { |move| @visited_positions.include?(move) }
    @visited_positions += moves
    moves
  end

  def find_path(start_node, end_pos) # returns search result if it exits, else nil
    return nil if start_node.nil?
    return start_node if start_node.value == end_pos

    start_node.children.each do |child|
      search_result = find_path(child, end_pos)
      return search_result unless search_result.nil?
    end

    nil
  end

  def trace_back_path(end_node) # we pass the find path return value here and work backwords to find path
    path = []
    current_node = find_path(root_node, end_node)

    until current_node == root_node
      path << current_node.value
      current_node = current_node.parent
    end

      path << current_node.value
      path.reverse
  end

end # end of class

n = KnightPathFinder.new([0,0])
puts n.trace_back_path([7,6]).to_s
puts n.trace_back_path([6,2]).to_s
