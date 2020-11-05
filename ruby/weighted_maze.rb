require 'core/weighted_grid'
require 'algorithms/recursive_backtracker'

grid = WeightedGrid.new(20, 20)
RecursiveBacktracker.on(grid)
grid.braid(0.5)

start = grid[0, 0]
finish = grid[grid.rows - 1, grid.columns - 1]

grid.distances = start.distances.path_to(finish)

filename = 'results/weighted_original.png'
grid.to_png(colored: true).save(filename)

lava = grid.distances.cells.sample
lava.weight = 50

grid.distances = start.distances.path_to(finish)

filename = 'results/weighted_rerouted.png'
grid.to_png(colored: true).save(filename)
