require 'core/grid'
require 'algorithms/recursive_backtracker'

grid = Grid.new(20, 20)
RecursiveBacktracker.on(grid)

filename = 'results/recursive_backtracker.png'
grid.to_png.save(filename)
