require 'byebug'

class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    self.parent.children.reject! { |node| node == self } if parent

    @parent = new_parent
    new_parent.children << self unless new_parent.nil? ||
      new_parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "This is not a child" if child_node.parent.nil?
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    children.each do |child|
      current_value = child.dfs(target_value)
      return current_value if current_value
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end

    nil
  end

end



if __FILE__ == $PROGRAM_NAME

  n1 = PolyTreeNode.new("root1")
  n2 = PolyTreeNode.new("root2")
  n3 = PolyTreeNode.new("root3")

  # connect n3 to n1
  n3.parent = n1
  # connect n3 to n2
  n3.parent = n2

  # this should work
  raise "Bad parent=!" unless n3.parent == n2
  raise "Bad parent=!" unless n2.children == [n3]

  # this probably doesn't
  raise "Bad parent=!" unless n1.children == []
end
