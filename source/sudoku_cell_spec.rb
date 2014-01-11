require_relative 'sudoku_cell.rb'

describe SudokuCell do
  it "defaults to not solved" do
    sudoku_cell = SudokuCell.new(index = 4)
    expect(sudoku_cell.solved?).to eq(false)
  end
  it "knows when it's not solved" do
    sudoku_cell = SudokuCell.new(index = 4, value = 0)
    expect(sudoku_cell.solved?).to eq(false)
  end
  it "knows when it's solved" do
    sudoku_cell = SudokuCell.new(index = 4, value = 4)
    expect(sudoku_cell.solved?).to eq(true)
  end
  it "can be told be solved" do
    sudoku_cell = SudokuCell.new(index = 4, value = 0)
    expect {sudoku_cell.solve!(3)}.to change {sudoku_cell.solved?}.from(false).to(true)
  end

  it "knows it's own row" do
    sudoku_cell = SudokuCell.new(index = 0, value = 0)
    expect(sudoku_cell.row_index).to eq(0)

    sudoku_cell = SudokuCell.new(index = 8, value = 0)
    expect(sudoku_cell.row_index).to eq(0)

    sudoku_cell = SudokuCell.new(index = 9, value = 0)
    expect(sudoku_cell.row_index).to eq(1)

    sudoku_cell = SudokuCell.new(index = 80, value = 0)
    expect(sudoku_cell.row_index).to eq(8)

    sudoku_cell = SudokuCell.new(index = 50, value = 0)
    expect(sudoku_cell.row_index).to eq(5)
  end

  it "knows it's own column" do
    sudoku_cell = SudokuCell.new(index = 0)
    expect(sudoku_cell.column_index).to eq(0)

    sudoku_cell = SudokuCell.new(index = 8)
    expect(sudoku_cell.column_index).to eq(8)

    sudoku_cell = SudokuCell.new(index = 9)
    expect(sudoku_cell.column_index).to eq(0)

    sudoku_cell = SudokuCell.new(index = 80)
    expect(sudoku_cell.column_index).to eq(8)

    sudoku_cell = SudokuCell.new(index = 50)
    expect(sudoku_cell.column_index).to eq(5)
  end

# [0, 1, 2, 3, 4, 5, 6, 7, 8]
# [9, 10, 11, 12, 13, 14, 15, 16, 17]
# [18, 19, 20, 21, 22, 23, 24, 25, 26]
# [27, 28, 29, 30, 31, 32, 33, 34, 35]
# [36, 37, 38, 39, 40, 41, 42, 43, 44]
# [45, 46, 47, 48, 49, 50, 51, 52, 53]
# [54, 55, 56, 57, 58, 59, 60, 61, 62]
# [63, 64, 65, 66, 67, 68, 69, 70, 71]
# [72, 73, 74, 75, 76, 77, 78, 79, 80]

  it "knows it's own local grid index" do
    sudoku_cell = SudokuCell.new(index = 0)
    expect(sudoku_cell.local_grid_index).to eq(0)

    sudoku_cell = SudokuCell.new(index = 3)
    expect(sudoku_cell.local_grid_index).to eq(1)

    sudoku_cell = SudokuCell.new(index = 8)
    expect(sudoku_cell.local_grid_index).to eq(2)

    sudoku_cell = SudokuCell.new(index = 20)
    expect(sudoku_cell.local_grid_index).to eq(0)

    sudoku_cell = SudokuCell.new(index = 50)
    expect(sudoku_cell.local_grid_index).to eq(4)

    sudoku_cell = SudokuCell.new(index = 80)
    expect(sudoku_cell.local_grid_index).to eq(8)

    sudoku_cell = SudokuCell.new(index = 60)
    expect(sudoku_cell.local_grid_index).to eq(8)
  end
end