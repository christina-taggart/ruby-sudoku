require 'pry'

class Cell
  attr_accessor :value, :column, :row, :box

  def initialize(value, flat_index, size  = 81)
    @size = Math.sqrt(size).to_i
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

class Sudoku
  def initialize(board_string)
    @board_array = board_string.split("").to_a
    @array_of_cells = @board_array.each_with_index.map { |x, i| Cell.new(x, i) }
    @size = 81
  end

  def solve!
    new_board, old_board = []
    until !@array_of_cells.map { |cell| cell.value}.include?("0")
      old_board = @array_of_cells.map { |cell| cell.value }
      update_board
      new_board = @array_of_cells.map { |cell| cell.value }

      break if new_board == old_board
    end
    puts self.board
    if new_board == old_board
      p "recursing"
      recursive_solve(0)
    end
    # recursive_solve if @array_of_cells.map { |cell| cell.value}.include?("0")
  end

  def update_board
    @array_of_cells.each do |cell|
      if cell.value == "0"
        possible_values = possible_from_all(cell)
        if possible_values.length == 1
          cell.value = possible_values[0]
        end
      end
    end
  end

  def recursive_solve(index_of_cell_array)
    cell = @array_of_cells[index_of_cell_array]
    #p @array_of_cells.map { |cell| cell.value}

      if index_of_cell_array == @size
        puts "Solution is: \n\n #{self.board}"
        return true
      end

      if cell.value != "0"
        recursive_solve(index_of_cell_array + 1)
      else
        # Loop for each possible cell value
        possible_from_all(cell).each do |guess|
          # Set the cell value to the guess
          cell.value = guess
          #Run recursive solve on the next cell
          if recursive_solve(index_of_cell_array + 1)
            # If cell after current cell has returned true, return true
            return true
          else
            cell.value = "0"
          end
        end
      end
      return false
  end

  def possible_from_all(cell_to_test)
    attributes = ["row", "column", "box"]
    possible_values = ('1'..'9').to_a

    attributes.each do |att|
      @array_of_cells.each do |cell|
        if eval("cell_to_test.#{att} == cell.#{att}")
          possible_values.delete(cell.value)
        end
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
board_string = File.readlines('sample.unsolved.txt')[11].chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
# game.solve!

puts game.board

# cell_a = Cell.new(0, 1)
# cell_b = Cell.new(0, 31)
# cell_c = Cell.new(7, 32)

# p game.possible_from_all(cell_a) == ["4", "7"]
# p game.possible_from_all(cell_b) == ["4", "5"]
# p game.possible_from_all(cell_c)
game.solve!

# puts game.board

