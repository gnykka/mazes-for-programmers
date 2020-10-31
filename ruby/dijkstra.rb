require 'core/distance_grid'
require 'algorithms/sidewinder'

grid = DistanceGrid.new(5, 5)
Sidewinder.on(grid)

start = grid[0, 0]
distances = start.distances

grid.distances = distances
puts grid

puts
grid.distances = distances.path_to(grid[grid.rows - 1, 0])
puts grid
