def get_local_grid(board, box_num)
    board = board.each_slice(27).to_a
    box_row = (box_num-1) / 3
    box_column = (box_num-1) % 3
    section_to_search = board[box_row]
    section_to_search = section_to_search.each_slice(9).to_a
    section_to_search = section_to_search.transpose.each_slice(3).to_a
    local_grid = section_to_search[box_column].flatten
  end

  a= (1..81).to_a

 p get_local_grid(a, 6)