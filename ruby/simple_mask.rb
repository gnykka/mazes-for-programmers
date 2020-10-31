require 'core/mask'
require 'core/masked_grid'
require 'algorithms/recursive_backtracker'

mask = Mask.new(5, 5)

mask[0, 0] = false
mask[2, 2] = false
mask[4, 4] = false

grid = MaskedGrid.new(mask)
RecursiveBacktracker.on(grid)

puts grid
