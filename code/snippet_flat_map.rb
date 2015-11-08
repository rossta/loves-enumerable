# From JEG2

require 'pp'

chess_squares = ("A".."H").flat_map do |col|
  (1..8).map { |row| "#{col} #{row}" }
end

pp chess_squares

# ["A 1",
#  "A 2",
#  "A 3",
#  "A 4",
#  ...
