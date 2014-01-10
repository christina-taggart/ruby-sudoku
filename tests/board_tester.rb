require_relative '../source/sudoku.rb'

test_board = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")

 puts test_board.board


# p '==============================='

# p test_board.get_values_in_row(0)

# p test_board.get_values_in_col(0)

# p '==============================='
# p test_board.get_values_in_box(0,0) == ["1", "0", "5", "0", "9", "0", "2", "0", "0"]

# p test_board.get_values_in_box(0,1) == ["8", "0", "2", "0", "7", "6", "4", "0", "0"]

# p test_board.get_values_in_box(2,2) == ["0", "3", "0", "5", "0", "1", "9", "0", "0"]

# p '==============================='
# test_board.solve!
# puts test_board.board