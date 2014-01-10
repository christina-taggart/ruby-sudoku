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

require 'matrix'

class Sudoku
  # initialize converts our board string into a matrix.
  def initialize(board_string)
    board = []
    board_string = board_string.split("")
    board_string.map! { |number| number.to_i }
    board_string.each_slice(9) {|row| board << row }
    @matrix_board = Matrix.rows(board)
  end

  def solve!
    @possible_numbers = []
  end

  # Returns a string representing the current state of the board.
  def board
      board_string = ""
      row = 0
      while row <= 8
        board_string += @matrix_board.row(row).to_a.to_s + "\n"
        row += 1
      end
      board_string.gsub(/,/, " ")
  end

  def get_row(square_index)
    return @matrix_board.row(square_index[0]).to_a
  end

  def get_column(square_index)
    return @matrix_board.column(square_index[1]).to_a
  end
end


#-----DRIVERS-----

board_string = File.readlines('sample.unsolved.txt').first.chomp
game = Sudoku.new(board_string)

puts game.board