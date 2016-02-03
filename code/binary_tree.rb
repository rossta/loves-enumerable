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

    @left.pre_order(&Proc.new) if @left
    yield @value
    @right.pre_order(&Proc.new) if @right
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

  tree = BinaryTree.new("a",
                        BinaryTree.new("b",
                                       BinaryTree.new("d"),
                                       BinaryTree.new("e")),
                        BinaryTree.new("c",
                                       BinaryTree.new("f")))

  puts "Pre-order"
  tree.pre_order { |v| puts v }

  puts "In-order"
  tree.in_order { |v| puts v }

  puts "Post-order"
  tree.post_order { |v| puts v }

  puts "Breadth-first"
  tree.breadth_first { |v| puts v }
end
