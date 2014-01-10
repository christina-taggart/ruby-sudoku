class Sudoku
  def initialize(given,given_row)
    @given = given
    @needed = [1,2,3,4,5,6,7,8,9]
    @rows = create_rows
  end

  #def solve!
  #complete is 1..9
  #needed starts at 1..9
    def check_row(given_row)
     checking = given_row.clone.delete_if {|element| element == 0}
     @needed -= checking
   end
#create a nested array of rows from original given string
   def create_rows
       rows = []
       given = @given.split("")
    until given.length == 0
       row = given.slice!(0..8)
       rows << row
    end
      rows
   end

  #end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    p @given.to_s
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
given = File.readlines('sample.unsolved.txt').first.chomp
 given_row = [0,0,3,5,0,1,0,9,4]
    needed = [1,2,3,4,5,6,7,8,9]
game = Sudoku.new(given,given_row)

# Remember: this will just fill out what it can and not "guess"
# game.solve!

p game.board == "105802000090076405200400819019007306762083090000061050007600030430020501600308900"
p game.check_row([0,0,3,5,0,1,0,9,4]) == [2, 6, 7, 8]
p game.create_rows