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
    @sudoku_board = Matrix.rows(formatted_board)
  end

  def solve!
    test_block = @sudoku_board.minor(0..2,0..2)
    row_coord = 0
    col_coord = 0
    invalid_guesses = []
    valid_guesses = []
    if test_block[row_coord,col_coord] != 0
      col_coord += 1
      if col_coord > 2
        row_coord += 1
        col_coord = 0
      else # => This block of code needs to go into another method
        test_block.each do |x|
          if x != 0
            invalid_guesses << x
          end # => Ends if statement

        end #=> Ends each loop that adds to the invalid guesses array
        @sudoku_board.column(col_coord).each do |x|
          if x != 0
            invalid_guesses << x
          end # => Ends if statement
        end #=> Ends the limit loop (keeps from going outside the block)
        @sudoku_board.row(row_coord).each do |x|
          if x != 0
            invalid_guesses << x
           end
          end # => Ends if statement
            valid_guesses = (1..9).to_a - invalid_guesses.sort.uniq!
            if valid_guesses.length == 1
              test_block[row_coord,col_coord] = valid_guesses
        end
      end  #=> ends 0 finding loop.
    end
  end #=> Ends solve! Method

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    @board_string = ""
    line = 0
    until line > 8
      @sudoku_board.row(line)
      line += 1
    end
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board
