require 'pry'

class Sudoku
  def initialize(board_string)
    @board_string = board_string
    formatted_board = @board_string.scan(/\d{9}/)
    formatted_board.map! { |x| x.scan(/./) }
    formatted_board.each do |x|
      x.map! do |y|
        y.to_i
      end
    end
    @sudoku_board = formatted_board
  end

  def block(range1, range2)
    @sudoku_board[range1].map { |row| row[range2] }
  end

  def get_block(block_row, block_column)
    if block_row == 0
      range1 = 0..2
    elsif block_row == 1
      range1 = 3..5
    else
      range1 = 6..8
    end

    if block_column == 0
      range2 = 0..2
    elsif block_column == 1
      range2 = 3..5
    else
      range2 = 6..8
    end
    block(range1,range2)
  end

  def return_column(index)
    @sudoku_board.map {|row| row[index]}
  end

  def return_row(index)
    @sudoku_board[index]
  end

  def return_box(box)
    box.flatten
  end
#perhaps, work from the full puzzle array, and get the block only for the values
# of box_numbers using the ranges. otherwise get row and column from whole board
  def solve!
    [0,1,2].each do |this_row_block| #=> 0
      [0,1,2].each do |this_column_block| #=> 0
        test_block = get_block(this_row_block, this_column_block) #=> 0,0
        box_numbers = test_block.flatten
        invalid_guesses = []
        valid_guesses = []
        test_block.each_with_index do |row, row_index| # => 0
          row.map.with_index do |cell, col_index| # => 1
            if cell == 0
             invalid_guesses << return_column(this_column_block * 3 + col_index)
             invalid_guesses << return_row(this_row_block * 3 + row_index)
             invalid_guesses << box_numbers
             valid_guesses = (1..9).to_a - invalid_guesses.flatten
             p "#{row_index} and #{col_index} Here are the valid guesses #{valid_guesses}"
             invalid_guesses = []
             if valid_guesses.length == 1

            end
          end
        end
      end
    end
  end

    # Returns a string representing the current state of the board
    # Don't spend too much time on this method; flag someone from staff
    # if you are.
    def board
      @sudoku_board.map { |row| row.inspect }.join("\n")
    end
end

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').first.chomp

game = Sudoku.new(board_string)


# Remember: this will just fill out what it can and not "guess"
game.solve!

#puts game.board
# p game.block(0..2,0..2)
# p game.return_column(1)
# p game.return_row(1)
