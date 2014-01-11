def get_grid_number(index)
  sliced_numbers = (1..81).to_a.each_slice(27).to_a
  section = sliced_numbers.find{|num| num.include?(index)}.each_slice(9).to_a.transpose.each_slice(3).to_a.flatten
  box_number = section.index(index) / 9
  box_number += (index / 27 ) * 3 + 1
  index == 81 ? 9 : box_number
end
a = 81
  p get_grid_number(a)