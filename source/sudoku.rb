require 'matrix'

class Sudoku
  def initialize(board_string)
    board = []
    board_string.split("").each_slice(9) {|row| board << row }
    matrix_board = Matrix.rows(board)
    # p board
    # p "________"
    # p matrix_board
    # puts matrix_board[1,1]
  end

  def solve!
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board

  end
end


#-----DRIVERS-----

board_string = File.readlines('sample.unsolved.txt').first.chomp
game = Sudoku.new(board_string)

p board_string

game.solve!

