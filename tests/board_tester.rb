require_relative '../source/sudoku.rb'

test_board = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")

p 'original board: '
 puts test_board.board


p '==============================='

p 'testing grab values in row: '
p test_board.get_values_in_row(0) == ["1", "0", "5", "8", "0", "2", "0", "0", "0"]

p 'testing grab values in column: '
p test_board.get_values_in_col(0) == ["1", "0", "2", "0", "7", "0", "0", "4", "6"]

p '==============================='

p 'testing grab values in upper left box (0,0): '
p test_board.get_values_in_box(0,0) == ["1", "0", "5", "0", "9", "0", "2", "0", "0"]

p 'testing grab values in top middle box (0,1): '
p test_board.get_values_in_box(0,1) == ["8", "0", "2", "0", "7", "6", "4", "0", "0"]

p 'testing grab values in lower right box (2,2): '
p test_board.get_values_in_box(2,2) == ["0", "3", "0", "5", "0", "1", "9", "0", "0"]

p '==============================='
test_board.solve!
p 'solved board: '
puts test_board.board