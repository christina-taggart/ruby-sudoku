class Sudoku

  attr_reader :sudoku_board

  def initialize(board_string)
    @board_string = board_string
    @sudoku_board = board_string.split("").each_slice(9).to_a.map! {|line| line.map! {|num| num.to_i}}
    @possible_answers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @box0, @box1, @box2, @box3, @box4, @box5, @box6, @box7, @box8 = [], [], [], [], [], [], [], [], []
  end

  def solve!
    row, column = 0, 0
    @sudoku_board.each do |row_on_board|
      row_on_board.each do |number|
        assign_to_box(row, column)
        possible_solutions = check_cell(row, column)
        if possible_solutions.length == 1 && @sudoku_board[row][column] == 0
          @sudoku_board[row][column] = possible_solutions[0]
        end
        # puts "#{number} is at (#{row}, #{column})."
        column += 1
      end
      column = 0
      row += 1
    end
  end

  # def get_all_coords
  #   row, column = 0, 0
  #   @sudoku_board.each do |row_on_board|
  #     row_on_board.each do |number|
  #       coordinates = (row, column)
  #       column += 1
  #     end
  #     column = 0
  #     row += 1
  #   end
  # end

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

  def assign_to_box(row, column)
    box_coords = [row / 3, column / 3]
    case box_coords
      when [0,0]
        @box0 << @sudoku_board[row][column]
      when [0,1]
        @box1 << @sudoku_board[row][column]
      when [0,2]
        @box2 << @sudoku_board[row][column]
      when [1,0]
        @box3 << @sudoku_board[row][column]
      when [1,1]
        @box4 << @sudoku_board[row][column]
      when [1,2]
        @box5 << @sudoku_board[row][column]
      when [2,0]
        @box6 << @sudoku_board[row][column]
      when [2,1]
        @box7 << @sudoku_board[row][column]
      when [2,2]
        @box8 << @sudoku_board[row][column]
    end
  end

  def check_box(row, column)
    box_coords = [row / 3, column / 3]
    case box_coords
      when [0,0]
        (1..9).to_a - @box0
      when [0,1]
        (1..9).to_a - @box1
      when [0,2]
        (1..9).to_a - @box2
      when [1,0]
        (1..9).to_a - @box3
      when [1,1]
        (1..9).to_a - @box4
      when [1,2]
        (1..9).to_a - @box5
      when [2,0]
        (1..9).to_a - @box6
      when [2,1]
        (1..9).to_a - @box7
      when [2,2]
        (1..9).to_a - @box8
    end
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.

  def check_cell(row, column)
    possible_in_cell = check_row(row) & check_column(column) & check_box(row, column)
  end

  def board

  end
end



# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp
board_string = "105802000090076405200400819019007306762083090000061050007600030430020501600308900"

game = Sudoku.new(board_string)
p game.sudoku_board
# p game.what_is_in_this_row(0) == [0, 9, 6, 0, 4, 0, 0, 0, 1]
# p game.check_row(0) == [2, 3, 5, 7, 8]
# p game.what_is_in_this_column(5) == [0, 0, 0, 0, 0, 3, 0, 0, 0]
# p game.what_is_in_this_column(0) == [0, 1, 5, 0, 0, 4, 0, 0, 0]
# p game.check_column(0) == [2, 3, 6, 7, 8, 9]

# p game.check_cell(0, 0) == [2, 3, 7, 8]
# Remember: this will just fill out what it can and not "guess"

50.times {p game.solve!}

puts game.board
#
# FOR TESTING

# def test(expected, actual)
#   p "You expected #{expected} and you got #{actual}."
#   actual == expected
# end

# p test([2, 3, 5, 7, 8], game.check_row(0))