class Sudoku
  def initialize(board_string)
    @board_string = board_string
    @sudoku_board = board_string.split("").each_slice(9).to_a
    @possible_answers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  def solve!

  end

  def what_is_in_this_row(row)
    @sudoku_board[row]
  end

  def check_row(row)
    possible_answers_in_row = @possible_answers.clone
    possible_answers_in_row.each do |num|
      possible_answers_in_row.delete(num) if @sudoku_board[row].include?(num)
    end
    possible_answers_in_row
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board

  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp
board_string = "096040001100060004504810390007950043030080000405023018010630059059070830003590007"
game = Sudoku.new(board_string)

p game.what_is_in_this_row(2)
p game.check_row(0) == ["2", "3", "5", "7", "8"]
# Remember: this will just fill out what it can and not "guess"
game.solve!

puts game.board
