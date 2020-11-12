require 'chunky_png'
require 'core/grid'
require 'core/weave_cells'

class WeaveGrid < Grid
  def initialize(rows, columns)
    @under_cells = []
    super
  end

  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        OverCell.new(row, column, self)
      end
    end
  end

  def tunnel_under(over_cell)
    under_cell = UnderCell.new(over_cell)
    @under_cells.push under_cell
  end

  def each_cell
    super
    @under_cells.each do |cell|
      yield cell
    end
  end

  def to_png(colored: false, cell_size: 10, inset: nil)
    super colored: colored, cell_size: cell_size, inset: (inset || 0.1)
  end

  def to_png_with_inset(img, cell, mode, cell_size, wall, x, y, inset, colored)
    x1, x2, x3, x4, y1, y2, y3, y4 =
      cell_coordinates_with_inset(x, y, cell_size, inset)

    if cell.is_a?(OverCell)
      super

      if colored && mode == :backgrounds
        color = background_color_for(cell)
        if color
          img.rect(x2, y1, x3, y2, color, color) if @under_cells.include?(cell.north)
          img.rect(x2, y3, x3, y4, color, color) if @under_cells.include?(cell.south)
          img.rect(x3, y2, x4, y3, color, color) if @under_cells.include?(cell.east)
          img.rect(x1, y2, x2, y3, color, color) if @under_cells.include?(cell.west)
        end
      end
    else
      if mode == :backgrounds
        color = colored ? background_color_for(cell) : ChunkyPNG::Color::WHITE
        if color
          img.rect(x2, y1, x3, y2, color, color) if cell.linked?(cell.north)
          img.rect(x2, y3, x3, y4, color, color) if cell.linked?(cell.south)
          img.rect(x3, y2, x4, y3, color, color) if cell.linked?(cell.east)
          img.rect(x1, y2, x2, y3, color, color) if cell.linked?(cell.west)
        end
      end

      if cell.vertical_passage?
        if !cell.north.deleted?
          img.line(x2, y1, x2, y2, wall)
          img.line(x3, y1, x3, y2, wall)
        end
        if !cell.south.deleted?
          img.line(x2, y3, x2, y4, wall)
          img.line(x3, y3, x3, y4, wall)
        end
      else
        if !cell.west.deleted?
          img.line(x1, y2, x2, y2, wall)
          img.line(x1, y3, x2, y3, wall)
        end
        if !cell.east.deleted?
          img.line(x3, y2, x4, y2, wall)
          img.line(x3, y3, x4, y3, wall)
        end
      end
    end
  end
end
