require 'pry'

class Cell
  attr_accessor :value, :column, :row, :box

  def initialize(value, flat_index, size  = 81)
    @size = Math.sqrt(size).to_i #Math.sqrt(flat_index.length)
    @value = value
    @column = flat_index % @size + 1
    @row = flat_index / @size + 1
    @box = find_box(@column, @row)
    @possible_values = []
  end

  def find_box(column, row)
    boxes = {0 => 1, 2 => 2, 4 => 3, 3 => 4, 5 => 5, 7 => 6, 6 => 7, 8 => 8, 10 => 9}
    box_size = Math.sqrt(@size).to_i
    column_normalized = (column - 1) / box_size
    row_normalized = (row - 1) / box_size
    box_key = 2 * column_normalized + 3 * row_normalized
    boxes[box_key]
  end

end




e_coli = Cell.new(5, 2)
p e_coli.column == 3
p e_coli.row == 1
e_coli.box == 1

test = Cell.new(8, 3)
p test.box == 2







class Sudoku
  def initialize(board_string)
    @board_array = board_string.split("").to_a
    @array_of_cells = @board_array.each_with_index.map { |x, i| Cell.new(x, i) }
    # board_of_cells = board_of_cells.map! { |x| x.cell}
  end

  # Iterate through each cell where value != 0
    # Check to see possible from column
    # Check to see possible from row
    # Check to see possible from box
    # Assign intersection of above 3 to possible values

    # Maybe: if intersection.length == 1 assign value to cell

  def solve!
      # binding.pry
  end

  # Return possible values based on row
  def possible_from_column(cell_to_test)
    possible_values = ('1'..'9').to_a
    @array_of_cells.each do |cell|
      if cell_to_test.column == cell.column
        puts "Value to delete: #{cell.value}"
        possible_values.delete(cell.value)
      end
    end
    possible_values
  end

  # Return possible values based on column
  def possible_from_row(cell_to_test)
    possible_values = ('1'..'9').to_a
    @array_of_cells.each do |cell|
      if cell_to_test.row == cell.row
        possible_values.delete(cell.value)
      end
    end
    possible_values
  end

  # Return possible values based on box
  def possible_from_box(cell_to_test)
    possible_values = ('1'..'9').to_a
    @array_of_cells.each do |cell|
      if cell_to_test.box == cell.box
        possible_values.delete(cell.value)
      end
    end
    possible_values
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    @array_of_cells.each_slice(9).each do |slice|
      slice.each { |cell| print "#{cell.value}  " }
      puts "\n"
    end
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
# game.solve!

puts game.board

p game.possible_from_column(e_coli)
p game.possible_from_row(e_coli)
p game.possible_from_box(e_coli)