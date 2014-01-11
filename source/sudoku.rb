class Sudoku
  def initialize(board_string)
    @board = board_string
    @solved_board = nil
  end

  def solve!
    board = @board



    @solved_board = ""
  end

  def print_board
    board = ""
    @board.split("").each_slice(9) do |slice|
      board += slice.join(" ") + "\n"
    end
    board
  end
  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    @solved_board || @board
  end

  # pass in two arrays, get the values from each array
  # that aren't in the other array
  def get_set_diff (set1, set2)
    (set1 - set2) + (set2 - set1)
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
 # board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

# # Remember: this will just fill out what it can and not "guess"
# game.solve!

p game.board


# @board == board at beginning
# @solved == most up-to-date board

# find_next_empty_space(starting_point = 0)

# can_current_space_be_solved(current_space)

# set_space_as_solved(solved_space)