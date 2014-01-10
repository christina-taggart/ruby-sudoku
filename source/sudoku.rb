require 'matrix'

class Sudoku
  def initialize(board_string)
    @board_string = board_string
    formatted_board = @board_string.scan(/\d{9}/)
    formatted_board.map! do |x|
      x.scan(/./)
    end
    formatted_board.each do |x|
      x.map! do |y|
        y.to_i
      end
    end
    formatted_board
    sudoku_board = Matrix.rows(formatted_board)
p sudoku_board[0]
  end

  def solve!
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board

  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board
