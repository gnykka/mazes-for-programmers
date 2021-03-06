require 'core/distances'

class Cell
  attr_reader :row, :column
  attr_accessor :deleted
  attr_accessor :north, :south, :east, :west

  def initialize(row, column)
    @row = row
    @column = column
    @links = []
    @deleted = false
  end

  def link(cell, bidi=true)
    @links.push(cell)
    cell.link(self, false) if bidi
  end

  def unlink(cell, bidi=true)
    @links.delete(cell)
    cell.unlink(self, false) if bidi
  end

  def links
    @links
  end

  def linked?(cell)
    @links.include?(cell)
  end

  def deleted?
    @deleted
  end

  def neighbors
    list = []
    list << north if north
    list << south if south
    list << east if east
    list << west if west

    list
  end

  def distances
    distances = Distances.new(self)
    frontier = [ self ]

    while frontier.any?
      new_frontier = []

      frontier.each do |cell|
        cell.links.each do |linked|
          next if distances[linked]
          distances[linked] = distances[cell] + 1
          new_frontier << linked
        end
      end

      frontier = new_frontier
    end

    distances
  end
end
