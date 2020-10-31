require 'core/hex_grid'
require 'algorithms/recursive_backtracker'

grid = HexGrid.new(10, 12)
RecursiveBacktracker.on(grid)

filename = 'results/hex.png'
grid.to_png.save(filename)

start = grid[0, 0]
grid.distances = start.distances

filename = 'results/hex_colorized.png'
grid.to_png(colored: true).save(filename)
