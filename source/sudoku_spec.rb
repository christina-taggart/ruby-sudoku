require_relative 'sudoku.rb'

def assert (expected, actual, line_number)
  if (expected == actual)
    print "."
  else
    puts "FAILED! Expected #{expected}, got #{actual} on #{line_number}"
  end
end

sudoku = Sudoku.new("")

assert([1, 9], sudoku.get_set_diff([1,2,3], [2,3,9]), __LINE__)
assert([2,3,9], sudoku.get_set_diff([], [2,3,9]), __LINE__)
assert([2,3,9], sudoku.get_set_diff([2,3,9], []), __LINE__)
assert([], sudoku.get_set_diff([1,2,3], [1,2,3]), __LINE__)

sudoku = Sudoku.new('609238745274561398853947621486352179792614583531879264945723816328196457167485932')
sudoku.solve!
assert('619238745274561398853947621486352179792614583531879264945723816328196457167485932', sudoku.board, __LINE__)