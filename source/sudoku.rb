=begin
class Sudoku
  def initialize(board_string)
  end

  def solve!
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board

  end
end

=end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.


# game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"


class Cell
  attr_accessor :row, :column, :value, :local_grid, :possible_set
  def initialize
    @row = 0
    @column = 0
    @value = 0
    @local_grid = 0
    @possible_set = (1..9).to_a
  end
end

class Sudoku
  attr_accessor :board
  def initialize(board_string)
    @number_list = board_string.split("").map! {|num| num.to_i}
    @board = []
    81.times {@board << Cell.new}
    sliced_board = @board.each_slice(9).to_a
    @row1 = sliced_board[0]
    @row2 = sliced_board[1]
    @row3= sliced_board[2]
    @row4 = sliced_board[3]
    @row5 = sliced_board[4]
    @row6 = sliced_board[5]
    @row7 = sliced_board[6]
    @row8 = sliced_board[7]
    @row9 = sliced_board[8]
    @rows = [@row1, @row2,@row3,@row4,@row5,@row6,@row7,@row8,@row9]

    vertical_sliced_board = sliced_board.transpose

    @column1 = vertical_sliced_board[0]
    @column2 = vertical_sliced_board[1]
    @column3= vertical_sliced_board[2]
    @column4 = vertical_sliced_board[3]
    @column5 = vertical_sliced_board[4]
    @column6 = vertical_sliced_board[5]
    @column7 = vertical_sliced_board[6]
    @column8 = vertical_sliced_board[7]
    @column9 = vertical_sliced_board[8]
    @columns = [@column1, @column2,@column3,@column4,@column5,@column6,@column7,@column8,@column9]

    @box1 = get_local_grid(1)
    @box2 = get_local_grid(2)
    @box3 = get_local_grid(3)
    @box4 = get_local_grid(4)
    @box5 = get_local_grid(5)
    @box6 = get_local_grid(6)
    @box7 = get_local_grid(7)
    @box8 = get_local_grid(8)
    @box9 = get_local_grid(9)
    @boxes = [@box1, @box2, @box3, @box4, @box5, @box6, @box7, @box8, @box9]

    @board.each do |cell|
      cell_index = @board.index(cell)
      cell.value = @number_list[cell_index]
      cell.row = @rows[cell_index / 9]
      cell.column = @columns[cell_index % 9]
      # cell.local_grid = @boxes.find {|box| box.include?(cell)}
    end

  end

  def get_local_grid(box_num)
    board = @board.each_slice(27).to_a
    box_row = (box_num-1) / 3
    box_column = (box_num-1) % 3
    section_to_search = board[box_row]
    section_to_search = section_to_search.each_slice(9).to_a
    section_to_search = section_to_search.transpose.each_slice(3).to_a
    # p section_to_search.length
    local_grid = section_to_search[box_column]
  end
end
board_string = File.readlines('sample.unsolved.txt').first.chomp

sudoku = Sudoku.new(board_string)
sudoku.board.each {|x| puts "#{x.local_grid} #{x.value}"}












