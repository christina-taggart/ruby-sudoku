class Cell
  attr_accessor :value, :row, :col, :box

  def initialize(index, value = 0)
    @row = (index / 9) + 1
    @col = (index % 9) + 1
    @box = 0
    find_box
    @value = value
    @possible_nums = []
    @not_possible = []
  end

  private
  def find_box
    @box = 1 if @row <= 3 && @col <= 3
    @box = 2 if @row <= 3 && (4..6).include?(@col)
    @box = 3 if @row <= 3 && @col > 6
    @box = 4 if (4..6).include?(@row) && @col <= 3
    @box = 5 if (4..6).include?(@row) && (4..6).include?(@col)
    @box = 6 if (4..6).include?(@row) && @col > 6
    @box = 7 if @row > 6 && @col <= 3
    @box = 8 if @row > 6 && (4..6).include?(@col)
    @box = 9 if @row > 6 && @col > 6
  end

end


class Sudoku

  def initialize(board_string)
    @board = []
    board_string.chars.each_with_index do |value, index|
     @board << Cell.new(index, value)
    end
  end

  def solve!
  end

  def find_used_values(cell)
    used_values = []
    used_values << get_box(cell.box)
    used_values << get_row(cell.row)
    used_values << get_col(cell.col)
    used_values.map!{ |cell| cell.value }
  end

  def board
    @board.each_slice(9).each do |slice|
      slice.each{ |cell| print "#{cell.value} " }
      puts ""
    end
  end

  def get_box(box_num)
    @board.find_all{ |cell| cell.box == box_num }
  end

  def get_row(row_num)
    @board.find_all{ |cell| cell.row == row_num }
  end

  def get_col(col_num)
    @board.find_all{ |cell| cell.col == col_num }
  end

end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)

game.board

puts "\n--- box ---"
game.get_box(1).each{ |cell| print "#{cell.value} " }
puts "\n--- row ---"
game.get_row(1).each{ |cell| print "#{cell.value} " }
puts "\n--- col ---"
game.get_col(1).each{ |cell| print "#{cell.value} " }

# Remember: this will just fill out what it can and not "guess"
# game.solve!

# puts game.board
