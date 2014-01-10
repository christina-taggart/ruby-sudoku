require 'matrix'

class Sudoku
  def initialize(board_string)
    board = []
    board_string.split("").each_slice(9) {|row| board << row }
    @matrix_board = Matrix.rows(board)
    p @matrix_board.to_a
  end

  def solve!
    @possible_numbers = []
  end


  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
      #p @board.each {|row| p row}
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

game.solve!

p game.get_column([0,2])
