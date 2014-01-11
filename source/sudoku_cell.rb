class SudokuCell
  attr_reader :row_index, :column_index, :index, :value

  def initialize(index, value = 0)
    @index = index
    @value = value
    @row_index, @column_index = index.divmod(9)
  end

  def local_grid_index
    row = @row_index / 3
    col = @column_index / 3
    row * 3 + col
  end

  def solved?
    @value != 0
  end

  def solve!(new_value)
    @value = new_value
  end
end