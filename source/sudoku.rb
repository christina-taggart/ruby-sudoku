# #-----PSEUDOKU CODE FOR SOLVE!-----
# INPUT: an 81 digit string representing a sudoku board, with blank
#        spaces represented by 0.
# OUTPUT: the same 81 digit string with the blank spaces substituted
#         with numbers between 1–9 according to the rules of sudoku.

# A solution for a given square is found when it is the only instance
# of a number (e.g. 3) in the block, column, and row to which it
# belongs.
# 0. The BASE CASE is a board with no 0s.
# 1. For each blank square [i.e. == 0], retrieve all values for its:
#     - block (3x3 subsection of the board)
#     – column
#     - row
# 2. Eliminate repeats from these values. Numbers that are not among
#    theses values but are between 1-9 are the possible values for a
#    given square. For example, if our retrieved values are:
#     [1, 4, 5, 7, 8]
#    Possible values for the square are:
#     [2, 3, 6, 9]
# 3. Set squares with only one possible value to that value.
# 4. Pass this updated board to solve! recursively. With each recursive
#    call, more and more squares will be found with only one possible
#    value.
#------------------------------------

require 'matrix'

class Sudoku
  # initialize converts our board string into a matrix.
  attr_reader :matrix_board

  def initialize(board_string)
    board = []
    board_string = board_string.split("")
    board_string.map! { |number| number.to_i }
    board_string.each_slice(9) {|row| board << row }
    @matrix_board = Matrix.rows(board)
  end

  def solve!
    #BASE CASE: does the board contain any blank spaces (i.e. 0s)?
    @matrix_board unless @matrix_board.to_a.flatten.include?(0)
    #ELSE:
    @matrix_board.each_with_index do |square, row, col|
      if square == 0
        square_index = [row, col]
        not_possible_values = get_row(square_index) + get_column(square_index) + get_block(square_index)
        not_possible_values.uniq!.delete(0)
        possible_values = (1..9).to_a - not_possible_values
        if possible_values.length == 1
          temp_matrix_board = @matrix_board.to_a
          temp_matrix_board[row][col] = possible_values[0]
          @matrix_board = Matrix.rows(temp_matrix_board)
        end
      end
    end
  end

  # Returns a string representing the current state of the board.
  def board
      board_string = ""
      row = 0
      while row <= 8
        board_string += @matrix_board.row(row).to_a.to_s + "\n"
        row += 1
      end
      board_string.gsub(/[,\[\]]/, " ")
  end

  def get_row(square_index)
    @matrix_board.row(square_index[0]).to_a
  end

  def get_column(square_index)
    @matrix_board.column(square_index[1]).to_a
  end

  def get_block(square_index)
    row_range = get_range(square_index[0])
    col_range = get_range(square_index[1])
    @matrix_board.minor(row_range, col_range).to_a.flatten
  end

  def get_range(coordinate)
    case
      when coordinate >= 0 && coordinate <= 2
        (0..2)
      when coordinate >= 3 && coordinate <= 5
        (3..5)
      when coordinate >= 6 && coordinate <= 8
        (6..8)
      else
        raise "get_range failed"
    end
  end

end


#-----DRIVERS-----

board_string = File.readlines('sample.unsolved.txt').first.chomp
game = Sudoku.new(board_string)

def assert(test, error_message)
  unless test
    puts error_message
  end
end


assert((game.get_row([1,1]) == [0, 9, 0, 0, 7, 6, 4, 0, 5]), "get_row failed")
assert((game.get_column([1,1]) == [0, 9, 0, 1, 6, 0, 0, 3, 0]), "get_column failed")
assert((game.get_range(3) == (3..5)), "get_range failed")
assert((game.get_block([8,8]) == [0, 3, 0, 5, 0, 1, 9, 0, 0]), "get_block failed")

puts game.board
puts "------solving!-----"
game.solve!
puts game.board

# testing board with no 0s
# no_zeroes = Sudoku.new("115812111191176415211411819119117316762183191111161151117611131431121511611318911")
# no_zeroes.solve!
# puts no_zeroes.board