require 'core/weave_grid'
require 'algorithms/recursive_backtracker'

grid = WeaveGrid.new(30, 60)
RecursiveBacktracker.on(grid)

filename = 'results/weave.png'
grid.to_png(inset: 0.2).save(filename)

grid.braid(sparse: true)

filename = 'results/weave_weighted.png'
grid.to_png(inset: 0.2).save(filename)
