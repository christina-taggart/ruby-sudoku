class Sudoku
  def initialize(board_string)
    @board = board_string.split("").map(&:to_i)
                 @rows = Array.new(9) {@board.shift(9)}
                 @columns = @rows.transpose
                 @boxes= Array.new(9) {Array.new}

                 for x in 0..8 do
                         for y in 0..8 do
                                if x >=0 && x <= 2 && y >=0 &&y <= 2
                                  @boxes[0].push(@rows[x][y])
                                  elsif x >=0 && x <=2 && y >=3 &&y <=5
                                  @boxes[1].push(@rows[x][y])
                         elsif x >=0 && x <=2 && y >=6 &&y <=8
                                  @boxes[2].push(@rows[x][y])
                         elsif x >=3 && x <=5 && y >=0 &&y <=2
                                  @boxes[3].push(@rows[x][y])
                         elsif x >=0 && x <=2 && y >=3 &&y <=5
                                  @boxes[4].push(@rows[x][y])
                         elsif x >=3 && x <=5 && y >=6 &&y <=8
                                  @boxes[5].push(@rows[x][y])
                          elsif x >=6 && x <=8 && y >=0 &&y <=2
                                  @boxes[6].push(@rows[x][y])
                          elsif x >=6 && x <=8 && y >=3 &&y <=5
                                  @boxes[7].push(@rows[x][y])
                          elsif x >=6 && x <=8 && y >=6 &&y <=8
                                  @boxes[8].push(@rows[x][y])
                          end
                         end
                 end
  end        #ends initialize

        def check_row(row)
         [1,2,3,4,5,6,7,8,9] - @rows[row]
        end

        def check_column(column)
         [1,2,3,4,5,6,7,8,9] - @columns[column]
        end

        def check_box (x, y, answers)
                if x >=0 && x <= 2 && y >=0 &&y <= 2
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[0] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         elsif x >=0 && x <=2 && y >=3 &&y <=5
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[1] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         elsif x >=0 && x <=2 && y >=6 &&y <= 8
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[2] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         elsif x >=3 && x <=5 && y >=0 &&y <=2
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[3] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         elsif x >=3 && x <=5 && y >=3 &&y <= 5
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[4] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         elsif x >=3 && x <=5 && y >=6 &&y <= 8
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[5] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         elsif x >=6 && x <=8 && y >=0 &&y <=2
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[6] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         elsif x >=6 && x <=8 && y >=3 &&y <=5
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[7] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         elsif x >=6 && x <=8 && y >=6 &&y <=8
                 temp = [1,2,3,4,5,6,7,8,9]-@boxes[8] & answers
                 @rows[x][y]=temp[0] if temp.length==1
         end

        end #ends check box

        def solve!
                counter = 0
                begin
                continue = true
                for x in 0..8 do
                         for y in 0..8 do
                                 if @rows[x][y] == 0
                                 answers = []
                                        possible_from_row = check_row(x)
                                        possible_from_column = check_column(y)
                                 @columns = @rows.transpose
                                        answers = possible_from_row & possible_from_column
                                        check_box(x,y, answers)
                                        @rows.flatten.include?(0) ? continue = true : continue = false
                                         counter += 1
                                end
                         end
                 end
                end until continue == false || counter > 300
                puts "Puzzle unsolvable without guessing" if counter > 300
        end #ends solve!


  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    @rows.each {|row| p row}
  end

end #ends class

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

board_string = File.open("sample.unsolved.txt") {|line| line.readline}

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"
game.solve!

game.board