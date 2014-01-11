class Sudoku
  def initialize(given)
    @given = given
    @needed = [1,2,3,4,5,6,7,8,9]
    @rows = create_rows
    @columns = @rows.transpose
  end

#create a nested array of rows from original given string
   def create_rows
       rows = []
       given = @given.split("").map {|x| x.to_i}
    until given.length == 0
       row = given.slice!(0..8)
       rows << row
    end
      rows
   end

  def check(row_or_col_or_box)
    needed = @needed.clone
    needed -= row_or_col_or_box
    needed
  end

###psuedocode solve
#
def solve!

end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    p @rows.join
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
given = File.readlines('sample.unsolved.txt').first.chomp
 given_row = [0,0,3,5,0,1,0,9,4]
 given_column = [1, 0, 2, 0, 7, 0, 0, 4, 6]
    needed = [1,2,3,4,5,6,7,8,9]
game = Sudoku.new(given)


def assert(expected, actual)
  if expected == actual
    nil
  else
    "expected: #{expected} got #{actual}"
  end
end
p game.board == "105802000090076405200400819019007306762083090000061050007600030430020501600308900"
p assert([2, 6, 7, 8], game.check_row(given_row))
p game.check_row(given_row) == [2, 6, 7, 8]
p game.check_column(given_column) == [3, 5, 8, 9]
p game.create_rows


# Remember: this will just fill out what it can and not "guess"
# game.solve!





























 #      i = 0
 #      until i == @rows.length
 #         given_row = @rows[i]
 #         checking = given_row.clone.delete_if {|element| element == 0}
 #         rows_needed = @needed.clone
 #         rows_needed -= checking
 #         #p
 #         i += 1
 #      end
 #       rows_needed
 #   end

 # def check_column(given_column)
 #    i = 0
 #    until i == @columns.length
 #      given_column = @columns[i]
 #      checking = given_column.clone.delete_if {|element| element == 0}
 #      columns_needed = @needed.clone
 #      columns_needed -= checking
 #      #p
 #      i += 1
 #   end
 #   columns_needed
 # end