require 'core/triangle_grid'
require 'algorithms/recursive_backtracker'

grid = TriangleGrid.new(10, 17)
RecursiveBacktracker.on(grid)

filename = 'results/triangle.png'
grid.to_png.save(filename)

start = grid[0, 0]
grid.distances = start.distances

filename = 'results/triangle_colorized.png'
grid.to_png(colored: true).save(filename)
