require 'core/grid'
require 'algorithms/aldous_broder'

grid = Grid.new(20, 20)
AldousBroder.on(grid)

filename = 'results/aldous_broder.png'
grid.to_png.save(filename)
