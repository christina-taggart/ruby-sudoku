require_relative 'sudoku_board.rb'

describe SudokuBoard do
  it "splits string into cell objects" do
    sudoku_board = SudokuBoard.new('')
    test_string = '01230'
    results = sudoku_board.get_board_cells_from_string(test_string)

    expect(results.length).to eq(test_string.length)

    results.each do |cell|
      expect(cell.class).to eq(SudokuCell)
    end

    expect(results.first.solved?).to eq(false)
    expect(results.last.solved?).to eq(false)
    expect(results[2].solved?).to eq(true)
  end

  it "finds next empty cell" do
    sudoku_board = SudokuBoard.new('0123456780')
    empty_cell = sudoku_board.find_next_empty_cell

    expect(empty_cell.class).to eq(SudokuCell)
    expect(empty_cell.row_index).to eq(0)
    expect(empty_cell.column_index).to eq(0)

    empty_cell = sudoku_board.find_next_empty_cell(empty_cell)

    expect(empty_cell.class).to eq(SudokuCell)
    expect(empty_cell.row_index).to eq(1)
    expect(empty_cell.column_index).to eq(0)
  end

  test_board = "
    1 0 5 8 0 2 0 0 0
    0 9 0 0 7 6 4 0 5
    2 0 0 4 0 0 8 1 9
    0 1 9 0 0 7 3 0 6
    7 6 2 0 8 3 0 9 0
    0 0 0 0 6 1 0 5 0
    0 0 7 6 0 0 0 3 0
    4 3 0 0 2 0 5 0 1
    6 8 9 3 0 8 9 0 0"
  .gsub!(/\s+/, "")

 it "figures out if current space can be solved" do
    board = SudokuBoard.new(test_board)
    cell = SudokuCell.new(54)
    expect(board.can_current_space_be_solved(cell)).to eq(5)
  end

  it "gets solved cells related cells" do
    board = SudokuBoard.new(test_board)
    cell = SudokuCell.new(80, 1)
    results = board.get_solved_related_cells(cell)
    expect(results.length).to eq(12)
    expect(results[0].value).to eq(5)
    expect(results[1].value).to eq(9)
    expect(results[2].value).to eq(6)
    expect(results[3].value).to eq(3)
    expect(results[4].value).to eq(5)
    expect(results[5].value).to eq(1)
    expect(results[6].value).to eq(6)
    expect(results[7].value).to eq(8)
    expect(results[8].value).to eq(9)
    expect(results[9].value).to eq(3)
    expect(results[10].value).to eq(8)
    expect(results[11].value).to eq(9)
  end
  it "gets solved cells related cells" do
    board = SudokuBoard.new(test_board)
    cell = SudokuCell.new(0, 1)
    results = board.get_solved_related_cells(cell)
    expect(results.length).to eq(9)
    expect(results[0].value).to eq(1)
    expect(results[1].value).to eq(5)
    expect(results[2].value).to eq(8)
    expect(results[3].value).to eq(2)
    expect(results[4].value).to eq(9)
    expect(results[5].value).to eq(2)
    expect(results[6].value).to eq(7)
    expect(results[7].value).to eq(4)
    expect(results[8].value).to eq(6)
  end

  it "does the correct diff of arrays" do
    sudoku_board = SudokuBoard.new('')
    expect(sudoku_board.get_set_diff([1,2,3], [2,3,9])).to eq([1,9])
    expect(sudoku_board.get_set_diff([], [2,3,9])).to eq([2,3,9])
    expect(sudoku_board.get_set_diff([2,3,9], [])).to eq([2,3,9])
    expect(sudoku_board.get_set_diff([1,2,3], [1,2,3])).to eq([])
  end
end