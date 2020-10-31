require 'core/distance_grid'
require 'algorithms/sidewinder'

grid = DistanceGrid.new(5, 5)
Sidewinder.on(grid)

start = grid[0,0]

distances = start.distances
new_start, distance = distances.max

new_distances = new_start.distances
goal, distance = new_distances.max

grid.distances = new_distances.path_to(goal)
puts grid
