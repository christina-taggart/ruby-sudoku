require_relative 'sudoku_board.rb'

class Sudoku
  def initialize(board_string)
    @board = board_string
    @working_board = SudokuBoard.new(board_string)
  end

  def solve!
    cell = @working_board.find_next_empty_cell
    while cell
      solved_value = @working_board.can_current_space_be_solved(cell)
      if solved_value
        cell.solve!(solved_value)
        @working_board.solve!(cell)
        cell = @working_board.find_next_empty_cell
      else
        cell = @working_board.find_next_empty_cell(cell)
      end
    end
  end

  def board
    @working_board.to_s
  end
end