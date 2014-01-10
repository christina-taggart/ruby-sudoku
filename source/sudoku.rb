class Sudoku
  def initialize(given)
    @given = given
    @needed = [1,2,3,4,5,6,7,8,9]
    @rows = create_rows

  end

 #@given_row = @rows[i]
  #complete is 1..9
  #needed starts at 1..9
    def check_row(given_row)
      i = 0
    given_row = @rows[i]
    until i == @rows.length
       checking = given_row.clone.delete_if {|element| element == 0}
       @needed -= checking
       @needed
      end
     i += 1
   end

 def check_column(given_column)
    # columns = @rows.transpose
     checking = given_column.clone.delete_if {|element| element == 0}
     @needed -= checking
     # p columns
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
 # given_row = [0,0,3,5,0,1,0,9,4]
 # given_column = [1, 0, 2, 0, 7, 0, 0, 4, 6]
    needed = [1,2,3,4,5,6,7,8,9]
game = Sudoku.new(given)



p game.board == "105802000090076405200400819019007306762083090000061050007600030430020501600308900"
p game.check_row([1, 0, 5, 8, 0, 2, 0, 0, 0]) == [3, 4, 6, 7, 9]
p game.check_column([1, 0, 2, 0, 7, 0, 0, 4, 6]) == [3, 5, 8, 9]
p game.create_rows


# Remember: this will just fill out what it can and not "guess"
# game.solve!