require 'pry'
require 'pry-nav'
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
  def initialize(index)
    @row = []
    @column = []
    @value = 0
    @local_grid = 0
    @possible_set = (1..9).to_a
    @index = index
  end

  def solve
     # binding.pry
    if @value == 0
      total_elimination = (@row + @column + @local_grid).uniq.select{|x| x!=0}
      #p total_elimination
      # p @possible_set
      @possible_set -= total_elimination
      # p @possible_set


      if @possible_set.empty?
        # binding.pry
         puts "This is unsolvable"
      end
      if @possible_set.length == 1
        binding.pry
        @value += @possible_set[0]
        puts "Value changed to #{@value}"
        @row[@index / 9] = @value
        @column[@index % 9] = @value


      end
    end
  end
end

class Sudoku
  attr_accessor :board, :value_list
  def initialize(board_string)
    @number_list = board_string.split("").map! {|num| num.to_i}
    @board = []
    (0..80).each  { |n| @board << Cell.new(n)}
    sliced_board = @board.each_slice(9).to_a
    set_board
  end

  def set_board
    board_assign(@number_list)
  end

  def change_board
    @value_list = @board.map{|cell| cell.value}
    board_assign(@value_list)
  end

  def board_assign(list)
    @board.each do |cell|
      cell_index = @board.index(cell)
      cell.value = list[cell_index]
      cell.row = list.each_slice(9).to_a[cell_index / 9]
      cell.column = list.each_slice(9).to_a.transpose[cell_index % 9]
      grid_num = get_grid_number(cell_index+1)
      cell.local_grid = get_local_grid(list, grid_num).flatten
    end
  end

  def get_local_grid(board, box_num)
    board = board.each_slice(27).to_a
    box_row = (box_num-1) / 3
    box_column = (box_num-1) % 3
    section_to_search = board[box_row].each_slice(9).to_a.transpose.each_slice(3).to_a[box_column]
  end

  def get_grid_number(index)
    sliced_numbers = (1..81).to_a.each_slice(27).to_a
    return 9 if index == 81
    section = sliced_numbers.find{|num| num.include?(index)}.each_slice(9).to_a.transpose.each_slice(3).to_a.flatten
    box_number = section.index(index) / 9
    box_number += (index / 27 ) * 3 + 1
  end

  def solved?
    columns_complete = true
    rows_complete = true
    completed_item = (1..9).to_a
    (0..8).each do |n|
      columns_complete = false if @board[n].column.sort != completed_item
    end
    (0..80).step(9).each do |n|
      rows_complete = false if @board[n].row.sort != completed_item
    end
    columns_complete && rows_complete
  end
end
# board_string = File.readlines('sample.unsolved.txt').first.chomp
board_string = '094000007135800940000005030008310200012040580003058700040900000051002498300000170'
sudoku = Sudoku.new(board_string)
#sudoku.board.each {|x| puts "#{x.column} #{x.row} #{x.local_grid} #{x.value}"}

until sudoku.solved?
  sudoku.board.each do |cell|
    # p cell.value
    cell.solve
    sudoku.change_board
    # p "changing #{cell.value}"
    break if sudoku.solved?
  end

end


p sudoku.solved?
