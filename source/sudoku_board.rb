require_relative 'sudoku_cell.rb'

class SudokuBoard
  def initialize(board_string)
    @board = get_board_cells_from_string(board_string)
  end

  def get_board_cells_from_string(string)
    board_array_of_cells = []
    string.split('').each_index do |index|
      board_array_of_cells << SudokuCell.new(index, string[index].to_i)
    end
    board_array_of_cells
  end

  def find_next_empty_cell(starting_cell = nil)
    if starting_cell == nil
      starting_cell = 0
    else
      starting_cell = starting_cell.index + 1
    end
    board = @board.clone.drop(starting_cell)
    board.each do |cell|
      return cell unless cell.solved?
    end
    nil
  end

  def can_current_space_be_solved(cell)
    used_up_numbers = get_solved_related_cells(cell).map{ |related_cell| related_cell.value }
    unused_numbers = get_set_diff((1..9).to_a, used_up_numbers.uniq)
    return unused_numbers.first if unused_numbers.length == 1
    return false
  end

  def get_solved_related_cells(current_cell)
    @board.select do |cell|
      cell.solved? && (cell.row_index == current_cell.row_index ||
        cell.column_index == current_cell.column_index ||
        cell.local_grid_index == current_cell.local_grid_index)
    end
  end

  def solve!(cell)
    @board[cell.index].solve! (cell.value)
  end

  def get_set_diff (set1, set2)
    (set1 - set2) + (set2 - set1)
  end

  def to_s
    values = @board.map {|cell| cell.value }
    values.join('')
  end
end