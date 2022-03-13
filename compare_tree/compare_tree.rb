Node = Struct.new(:val, :left, :right)

def compare_tree(left, right)
  return true if [left, right].all? { _1.is_a?(NilClass) }
  return false if left&.val != right&.val || [left.class, right.class].uniq.length > 1

  return false unless compare_tree(left.left, right.left) && compare_tree(left.right, right.right)

  true
end

tree1 = Node.new(
  1,
  Node.new(
    2,
    Node.new(4),
    Node.new(5)
  ),
  Node.new(
    3,
    Node.new(6),
    Node.new(7)
  )
)
tree2 = Node.new(
  1,
  Node.new(
    2,
    Node.new(4),
    Node.new(
      5,
      Node.new(12),
      Node.new(13)
    )
  ),
  Node.new(
    3,
    Node.new(6),
    Node.new(7)
  )
)
tree3 = Node.new(
  1,
  Node.new(
    2,
    Node.new(4),
    Node.new(5)
  ),
  Node.new(
    3,
    Node.new(6),
    Node.new(7)
  )
)
tree4 = Node.new(
  1,
  Node.new(
    2,
    Node.new(40),
    Node.new(5)
  ),
  Node.new(
    3,
    Node.new(6),
    Node.new(7)
  )
)

puts compare_tree(tree1, tree3) # should be true
puts compare_tree(tree1, tree2) # should be false
puts compare_tree(tree1, tree4) # should be false
