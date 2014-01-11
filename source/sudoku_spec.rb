require_relative 'sudoku.rb'

describe Sudoku do
  it "does the correct diff of arrays" do
    sudoku = Sudoku.new('')
      expect(sudoku.get_set_diff([1,2,3], [2,3,9])).to eq([1,9])
      expect(sudoku.get_set_diff([], [2,3,9])).to eq([2,3,9])
      expect(sudoku.get_set_diff([2,3,9], [])).to eq([2,3,9])
      expect(sudoku.get_set_diff([1,2,3], [1,2,3])).to eq([])
  end
  it "correctly solves sudoku" do
    input = '609238745274561398853947621486352179792614583531879264945723816328196457167485932'
    expected = '619238745274561398853947621486352179792614583531879264945723816328196457167485932'
    sudoku = Sudoku.new(input)
    sudoku.solve!
      expect(sudoku.board).to eq(expected)
  end
  it "correctly prints board" do
    sudoku = Sudoku.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
    expected = <<EOS
1 0 5 8 0 2 0 0 0
0 9 0 0 7 6 4 0 5
2 0 0 4 0 0 8 1 9
0 1 9 0 0 7 3 0 6
7 6 2 0 8 3 0 9 0
0 0 0 0 6 1 0 5 0
0 0 7 6 0 0 0 3 0
4 3 0 0 2 0 5 0 1
6 0 0 3 0 8 9 0 0
EOS
    expect(sudoku.print_board).to eq(expected)
  end
  it "correctly finds next empty space" do
    # sudoku = Sudoku.new('105802000090076405200400819019007306762083090000061050007600030430020501600308900')
    # expect(sudoku.find_next_empty_space).to eq()
  end

  it "correctly converts string to 2-d array" do

  end
end