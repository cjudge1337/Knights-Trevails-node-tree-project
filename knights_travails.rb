require_relative 'lib/00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  DELTAS = [[2, 1], [2, -1], [-2, 1], [-2, -1],
            [1, 2], [1, -2], [-1, 2], [-1, -2]].freeze

  attr_accessor :start_pos, :visited_positions, :move_tree

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @move_tree = build_move_tree
  end

  def [](pos)
    x, y = pos
    @move_tree[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @move_tree[x][y] = value
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]

    until queue.empty?
      node = queue.shift
      node_moves = new_move_positions(node.value)
      node_moves.each { |move| node.add_child(PolyTreeNode.new(move)) }
      queue += node.children
    end

    root
  end

  def self.valid_moves(pos)
    all_new_moves = []

    DELTAS.each do |move|
      possible_move = [(pos[0] + move[0]), (pos[1] + move[1])]
      all_new_moves << possible_move
    end

    all_new_moves
  end

  def new_move_positions(pos)
    path_finder = KnightPathFinder.valid_moves(pos)

    new_moves = path_finder.reject do |move|
#debugger
      @visited_positions.include?(move)
    end
    new_moves = new_moves.select do |move|
      move[0].between?(0, 7) && move[1].between?(0, 7)
    end

    new_moves.each { |move| @visited_positions << move }
  end

  def find_path(end_pos)
    # Find path should search in your move tree for the end_pos
    # You should use either your dfs or bfs methods from the PolyTreeNode exercises
    # This will return a tree node which is the final destination.
    # Use #trace_path_back to finish up #find_path

    move_tree.dfs(end_pos)
  end

  def trace_path_back
    # This should trace back from the node to the root using PolyTreeNode#parent
    # As it goes up-and-up toward the root, it should add each value to an array
    # trace_path_back should return the values in order from the target node up to the root
    trace_path = []

    
  end


end


# KnightPathFinder.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
# KnightPathFinder.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
