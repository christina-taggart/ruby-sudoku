class SudokuCell

  def initialize(index, value = 0)
    @index = index
    @value = value
    @row, @col = index.divmod(9)
  end

  def row_index
    @row
  end

  def column_index
    @col
  end


  def local_grid_index
    local_grid_values = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
    ]
    row = (@row / 3).floor
    col = (@col / 3).floor
    local_grid_values[row][col]
  end

  def solved?
    @value != 0
  end

  def solve!(new_value)
    @value = new_value
  end
end