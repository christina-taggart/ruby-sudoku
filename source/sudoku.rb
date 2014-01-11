require 'pry'

class Sudoku
  def initialize(board_string)
    @board_string = board_string
    formatted_board = @board_string.scan(/\d{9}/)
    formatted_board.map! { |x| x.scan(/./) }
    formatted_board.each do |x|
      x.map! do |y|
        y.to_i
      end
    end
    @sudoku_board = formatted_board
  end

  def block(range1, range2)
    @sudoku_board[range1].map { |row| row[range2] }
  end

  def return_column
    @sudoku_board.map.with_index {|row, index| row[index % 3]}
  end

  def return_row(index)
    @sudoku_board[index]
  end

  def return_box(box)
    box.flatten
  end

  def solve!
    test_block = block((0..2), (0..2))
    box_numbers = test_block.flatten
    invalid_guesses = []
    valid_guesses = []
    test_block.each_with_index do |row, index|
      row.map do |column|
        if column == 0
         invalid_guesses << return_column
         invalid_guesses << return_row(index)
         invalid_guesses << box_numbers
         valid_guesses = (1..9).to_a - invalid_guesses.flatten
         invalid_guesses = []
        end
      end
  end

    #valid_guesses = (1..9).to_a - invalid_guesses
    # if valid_guesses.length == 1
    #   test_block[row_coord,col_coord] = valid_guesses.to_i
    # end
  end







    # Returns a string representing the current state of the board
    # Don't spend too much time on this method; flag someone from staff
    # if you are.
    def board
      @sudoku_board.map { |row| row.inspect }.join("\n")
    end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

game.board
