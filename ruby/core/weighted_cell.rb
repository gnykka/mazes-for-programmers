require 'core/cell'

class WeightedCell < Cell
  attr_accessor :weight

  def initialize(row, column)
    super(row, column)
    @weight = 1
  end

  def distances
    weights = Distances.new(self)
    pending = [ self ]

    while pending.any?
      cell = pending.sort_by { |c| weights[c] }.first
      pending.delete(cell)

      cell.links.each do |neighbor|
        total_weight = weights[cell] + neighbor.weight

        if !weights[neighbor] || total_weight < weights[neighbor]
          pending << neighbor
          weights[neighbor] = total_weight
        end
      end
    end

    weights
  end
end
