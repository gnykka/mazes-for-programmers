require 'core/grid'
require 'algorithms/recursive_backtracker'

grid = Grid.new(30, 30)
RecursiveBacktracker.on(grid)

filename = 'results/recursive_backtracker.png'
grid.to_png(inset: 0.2).save(filename)

grid.braid(sparse: true)

filename = 'results/recursive_backtracker_sparse.png'
grid.to_png(inset: 0.2).save(filename)
