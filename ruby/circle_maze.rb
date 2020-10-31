require 'core/polar_grid'
require 'algorithms/recursive_backtracker'

grid = PolarGrid.new(20)
RecursiveBacktracker.on(grid)

filename = 'results/circle_maze.png'
grid.to_png.save(filename)

start = grid[0, 0]
grid.distances = start.distances

filename = 'results/circle_maze_colorized.png'
grid.to_png(colored: true).save(filename)
