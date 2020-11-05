require 'core/grid'
require 'algorithms/recursive_backtracker'

grid = Grid.new(20, 20)
RecursiveBacktracker.on(grid)

start = grid[0, 0]
grid.distances = start.distances

filename = 'results/recursive_backtracker.png'
grid.to_png(colored: true, inset: 0.2).save(filename)
