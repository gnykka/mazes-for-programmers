require 'core/grid'
require 'algorithms/binary_tree'
require 'algorithms/sidewinder'
require 'algorithms/aldous_broder'
require 'algorithms/wilsons'
require 'algorithms/hunt_and_kill'
require 'algorithms/recursive_backtracker'

algorithms = [BinaryTree, Sidewinder, AldousBroder, Wilsons, HuntAndKill, RecursiveBacktracker]
names = ['binary_tree', 'sidewinder', 'aldous_broder', 'wilsons', 'hunt_and_kill', 'recursive_backtracker']
size = 50

algorithms.each_with_index do |algorithm, index|
  puts 'running #{algorithm}...'

  grid = Grid.new(size, size * 2)
  algorithm.on(grid)

  filename = 'results/all/#{names[index]}.png'
  grid.to_png.save(filename)

  start = grid[0, 0]
  grid.distances = start.distances

  filename = 'results/all/#{names[index]}_colorized.png'
  grid.to_png(colored: true).save(filename)
end

