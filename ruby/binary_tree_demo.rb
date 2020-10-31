require 'core/grid'
require 'algorithms/binary_tree'

grid = Grid.new(10, 10)
BinaryTree.on(grid)

filename = 'results/binary.png'
grid.to_png.save filename
