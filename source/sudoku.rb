class Cell
  attr_accessor :value, :row, :col, :box, :possible_nums

  def initialize(index, value = 0)
    @row = (index / 9) + 1
    @col = (index % 9) + 1
    @box = 0
    find_box
    @value = value
    @possible_nums = []
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
  attr_accessor :board

  def initialize(board_string)
    @board = []
    board_string.chars.each_with_index do |value, index|
     @board << Cell.new(index, value)
    end
  end

  def solve!
    board_vals = @board.map{ |cell| cell.value }
    while board_vals.include?("0")
      update_value
      board_vals = @board.map{ |cell| cell.value }
    end
  end

  def find_used_values(cell)
    used_values = []
    used_values << get_box(cell.box) << get_row(cell.row) << get_col(cell.col)
    used = used_values.flatten.map{ |cell| cell.value }
    used.delete("0")
    used.uniq
  end

  def update_possible_vals
    @board.each do |cell|
      if cell.value == "0"
        cell.possible_nums = ("1".."9").to_a - find_used_values(cell)
      end
    end
  end

  def update_value
    update_possible_vals
    @board.each do |cell|
      if cell.possible_nums.length == 1
        cell.value = cell.possible_nums[0]
      end
    end
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
def line(msg)
  puts "\n------- #{msg} -------"
end


board_string = File.readlines('sample.unsolved.txt')[7].chomp

game = Sudoku.new(board_string)
line("board")
game.board

line("box")
game.get_box(1).each_slice(3) do |slice|
  slice.each { |cell| print "#{cell.value} " }
  puts ""
end
line("row")
game.get_row(1).each{ |cell| print "#{cell.value} " }
line("col")
game.get_col(1).each{ |cell| puts "#{cell.value} " }

line("previous board")
game.board
line("updated board")
game.solve!
game.board

# Remember: this will just fill out what it can and not "guess"
# game.solve!

# puts game.board
