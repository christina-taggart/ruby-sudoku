class Sudoku
  def initialize(given,given_row)
    @given = given
    @given_row = [0,0,3,5,0,1,0,9,4]
    @needed = [1,2,3,4,5,6,7,8,9]
  end

  #def solve!
    def check_row(given_row)
     checking = given_row.clone.delete_if {|element| element == 0}
     @needed -= checking

     p @needed
   end

  #end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board

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

# puts game.board
game.check_row(given_row)