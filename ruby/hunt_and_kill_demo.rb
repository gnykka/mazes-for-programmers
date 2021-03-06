require 'core/grid'
require 'algorithms/hunt_and_kill'

grid = Grid.new(20, 20)
HuntAndKill.on(grid)

filename = 'results/hunt_and_kill.png'
grid.to_png.save(filename)

start = grid[grid.rows / 2, grid.columns / 2]
grid.distances = start.distances

filename = 'results/hunt_and_kill_colorized.png'
grid.to_png(colored: true).save(filename)

grid.braid()
grid.distances = start.distances

filename = 'results/hunt_and_kill_colorized_weighted.png'
grid.to_png(colored: true).save(filename)

