class Sudoku
  # 105802000 090076405 200400819
  # 019007306 762083090 000061050
  # 007600030 430020501 600308900
  def initialize(grid_string)
    @grid = Array.new(9) { Array.new(9) }
    @grid.each_with_index { |row, r_idx| row.each_with_index { |cell, c_idx| @grid[r_idx][c_idx] = grid_string.slice!(0) } }
  end

  def solve!
    until solved?
      p "executing complete_first_known_cell"
      complete_first_known_cell
    end
  end

  def complete_first_known_cell
    @grid.each_with_index do |row, r_idx|
      #p "scanning row: #{r_idx}"
      row.each_with_index do |cell, c_idx|
        if cell.to_i.zero?
          p "scanning cell: (#{r_idx},#{c_idx})"
          cell_possibilities = %w(1 2 3 4 5 6 7 8 9)
          p cell_possibilities
          p get_values_in_row(r_idx)
          get_values_in_row(r_idx).each { |row_value| p  cell_possibilities.delete(row_value) }
          p cell_possibilities

          p get_values_in_col(c_idx)
          get_values_in_col(c_idx).each { |col_value| p cell_possibilities.delete(col_value) }
          p cell_possibilities
          get_values_in_box(r_idx / 3, c_idx / 3).each { |box_value|  cell_possibilities.delete(box_value) }
          p cell_possibilities
          if cell_possibilities.length.eql?(1)
            @grid[r_idx][c_idx] = cell_possibilities[0]
            p "row: #{r_idx} col: #{c_idx} adding value: #{cell_possibilities[0]}"
            return nil
          end
        end
      end
    end
  end

  def solved?
    @grid.each_with_index { |row, r_idx| row.each_with_index { |cell, c_idx| return false if cell.to_i.zero? } }
    true
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
    pretty_grid = ""
    @grid.each { |row| pretty_grid += "#{row}\n" }
    pretty_grid
  end

  def get_values_in_row(row_idx)
    @grid[row_idx]
  end

  def get_values_in_col(col_idx)
    @grid.transpose[col_idx]
  end

  # expecting a box 0 through 8
  # (0,0) (0,1) (0,2)
  # (1,0) (1,1) (1,2)
  # (2,0) (2,1) (2,2)

  def get_values_in_box(box_row, box_col)
    first_row_in_box = box_row * 3
    first_col_in_box = box_col * 3

    box_values = []

    (first_row_in_box..first_row_in_box+2).to_a.each do |r_idx|
      (first_col_in_box..first_col_in_box+2).to_a.each do |c_idx|
        box_values << @grid[r_idx][c_idx]
      end
    end

    box_values
  end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
# board_string = File.readlines('sample.unsolved.txt').first.chomp

# game = Sudoku.new(board_string)

# # Remember: this will just fill out what it can and not "guess"
# game.solve!

# puts game.board
