class Sudoku

  attr_reader :sudoku_board

  def initialize(board_string)
    @board_string = board_string
    @sudoku_board = board_string.split("").each_slice(9).to_a.map! {|line| line.map! {|num| num.to_i}}
    @possible_answers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def solve!

  end

  def what_is_in_this_row(row)
    @sudoku_board[row]
  end

  def check_row(row)
    possible_answers_in_row = @possible_answers.clone
    (1..9).each do |num|
      possible_answers_in_row.delete(num) if @sudoku_board[row].include?(num)
    end
    possible_answers_in_row
  end

  def what_is_in_this_column(column)
    @sudoku_board.transpose[column]
  end

  def check_column(column)
    possible_answers_in_column = @possible_answers.clone
    (1..9).each do |num|
      possible_answers_in_column.delete(num) if @sudoku_board.transpose[column].include?(num)
    end
    possible_answers_in_column
  end
  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.

  def check_square(x, y)
    possible_in_square = check_row(x) & check_column(y)
  end

  def board

  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp
board_string = "096040001100060004504810390007950043030080000405023018010630059059070830003590007"
game = Sudoku.new(board_string)

# p game.sudoku_board.transpose
p game.what_is_in_this_row(0) == [0, 9, 6, 0, 4, 0, 0, 0, 1]
p game.check_row(0) == [2, 3, 5, 7, 8]
p game.what_is_in_this_column(5) == [0, 0, 0, 0, 0, 3, 0, 0, 0]
p game.what_is_in_this_column(0) == [0, 1, 5, 0, 0, 4, 0, 0, 0]
p game.check_column(0) == [2, 3, 6, 7, 8, 9]

p game.check_square(0, 0) == [2, 3, 7, 8]
# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board
