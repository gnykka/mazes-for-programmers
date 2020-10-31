require 'core/grid'
require 'core/polar_cell'

class PolarGrid < Grid
  def initialize(rows)
    super(rows, 1)
  end

  def [](row, column)
    return nil unless row.between?(0, @rows - 1)
    @grid[row][column % @grid[row].count]
  end

  def random_cell
    row = rand(@rows)
    col = rand(@grid[row].length)
    @grid[row][col]
  end

  def prepare_grid
    rows = Array.new(@rows)

    row_height = 1.0 / @rows
    rows[0] = [PolarCell.new(0, 0)]

    (1...@rows).each do |row|
      radius = row.to_f / @rows
      circumference = 2 * Math::PI * radius

      previous_count = rows[row - 1].length
      estimated_cell_width = circumference / previous_count
      ratio = (estimated_cell_width / row_height).round

      cells = previous_count * ratio
      rows[row] = Array.new(cells) { |col| PolarCell.new(row, col) }
    end

    rows
  end

  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.column

      if row > 0
        cell.cw = self[row, col + 1]
        cell.ccw = self[row, col - 1]
        
        ratio = @grid[row].length / @grid[row - 1].length
        parent = @grid[row - 1][col / ratio]
        parent.outward << cell
        cell.inward = parent
      end
    end
  end

  def distances=(distances)
    @distances = distances
    farthest, @maximum = distances.max
  end

  def to_png(colored: false, cell_size: 10)
    img_size = 2 * @rows * cell_size

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_size + 1, img_size + 1, background)
    center = img_size / 2

    [:backgrounds, :walls].each do |mode|
      each_cell do |cell|
        next if cell.row == 0

        theta = 2 * Math::PI / @grid[cell.row].length
        inner_radius = cell.row * cell_size
        outer_radius = (cell.row + 1) * cell_size
        theta_ccw = cell.column * theta
        theta_cw = (cell.column + 1) * theta

        ax = center + (inner_radius * Math.cos(theta_ccw)).to_i
        ay = center + (inner_radius * Math.sin(theta_ccw)).to_i
        bx = center + (outer_radius * Math.cos(theta_ccw)).to_i
        by = center + (outer_radius * Math.sin(theta_ccw)).to_i
        cx = center + (inner_radius * Math.cos(theta_cw)).to_i
        cy = center + (inner_radius * Math.sin(theta_cw)).to_i
        dx = center + (outer_radius * Math.cos(theta_cw)).to_i
        dy = center + (outer_radius * Math.sin(theta_cw)).to_i

        if colored && mode == :backgrounds
          color = background_color_for(cell)
          vector = ChunkyPNG::Vector(ax, ay, bx, by, dx, dy, cx, cy)
          img.polygon(vector, color, color) if color
        else
          img.line(ax, ay, cx, cy, wall) unless cell.linked?(cell.inward)
          img.line(cx, cy, dx, dy, wall) unless cell.linked?(cell.cw)
        end
      end
    end

    img.circle(center, center, @rows * cell_size, wall)
    img
  end
end
