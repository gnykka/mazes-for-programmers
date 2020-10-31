require 'core/grid'
require 'algorithms/binary_tree'
require 'algorithms/sidewinder'
require 'algorithms/aldous_broder'
require 'algorithms/wilsons'
require 'algorithms/hunt_and_kill'

algorithms = [BinaryTree, Sidewinder, AldousBroder, Wilsons, HuntAndKill]

tries = 100
size = 20

averages = {}
algorithms.each do |algorithm|
  puts 'running #{algorithm}...'

  deadend_counts = []
  tries.times do
    grid = Grid.new(size, size)
    algorithm.on(grid)
    deadend_counts << grid.deadends.count
  end

  total_deadends = deadend_counts.inject(0) { |s,a| s + a }
  averages[algorithm] = total_deadends / deadend_counts.length
end

total_cells = size * size
puts
puts 'Average dead-ends per #{size}x#{size} maze (#{total_cells} cells):'
puts

sorted_algorithms = algorithms.sort_by { |algorithm| -averages[algorithm] }

sorted_algorithms.each do |algorithm|
  percentage = averages[algorithm] * 100.0 / (size * size)
  puts '%14s : %3d/%d (%d%%)' % [algorithm, averages[algorithm], total_cells, percentage]
end
