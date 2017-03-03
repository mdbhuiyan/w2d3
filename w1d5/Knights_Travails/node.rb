class PolyTreeNode
  attr_reader :parent
  attr_accessor :value, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    case self.parent.nil?
    when true
        @parent = new_parent
    when false
        self.parent.children.delete(self)
        @parent = new_parent
    end

    # we're checking to ensure that we aren't adding this child to our parent twice
    # user can mistakenly try this...
    unless new_parent.nil? || new_parent.children.include?(self)
      new_parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self # remember this goes back to the parent= logic
  end

  def remove_child(child_node)
    raise 'Not a child' unless self.children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    self.children.each do |child|
      search_result = child.dfs(target)
      return search_result unless search_result.nil?
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      el = queue.shift
      return el if el.value == target
      el.children.each { |child| queue << child}
    end

    nil
  end

end
