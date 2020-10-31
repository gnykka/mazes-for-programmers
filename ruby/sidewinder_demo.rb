require 'core/grid'
require 'algorithms/sidewinder'

grid = Grid.new(3, 3)
Sidewinder.on(grid)

filename = 'results/sidewinder.png'
grid.to_png.save filename
