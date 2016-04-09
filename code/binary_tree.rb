class BinaryTree
  attr_reader :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def pre_order
    return enum_for(:pre_order) unless block_given?

    yield @value

    @left.pre_order(&Proc.new) if @left
    @right.pre_order(&Proc.new) if @right
  end

  def in_order
    return enum_for(:post_order) unless block_given?

    @left.in_order(&Proc.new) if @left
    yield @value
    @right.in_order(&Proc.new) if @right
  end

  def post_order
    return enum_for(:in_order) unless block_given?

    @left.post_order(&Proc.new) if @left
    @right.post_order(&Proc.new) if @right

    yield @value
  end

  def breadth_first
    return enum_for(:breadth_first) unless block_given?

    queue = []
    queue << self

    loop do
      break if queue.empty?

      node = queue.shift

      yield node.value

      queue << node.left if node.left
      queue << node.right if node.right
    end
  end
end

if __FILE__ == $0

  def print_tree(label, enum)
    puts "%s: %#{25 - label.length}s" % [label, enum.entries.join(' ')]
  end

  tree = BinaryTree.new("a",
          BinaryTree.new("b",
            BinaryTree.new("d"),
            BinaryTree.new("e")),
          BinaryTree.new("c",
            BinaryTree.new("f")))

  print_tree "Post-order", tree.pre_order
  print_tree "In-order", tree.in_order
  print_tree "Post-order", tree.post_order
  print_tree "Breadth-first", tree.breadth_first

  tree.breadth_first.
    with_index.
    partition { |n, i| i.odd? }.
    flat_map(&:join)
end
