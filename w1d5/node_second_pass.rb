class PolyTreeNode
  attr_accessor :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    if self.parent.nil?
      @parent = new_parent
    else
      self.parent.children.delete(self)
      @parent = new_parent
    end
    new_parent.children << self unless new_parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "THIS AINT YO CHILD!" unless children.include?(child_node)
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
    que = [self]

    until que.empty?
      node = que.shift
      return node if node.value == target
      node.children.each { |child| que << child }
    end

    nil
  end

end #end of class
