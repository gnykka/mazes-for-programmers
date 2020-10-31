require 'core/grid'
require 'algorithms/wilsons'

grid = Grid.new(20, 20)
Wilsons.on(grid)

filename = 'results/wilsons.png'
grid.to_png.save(filename)
