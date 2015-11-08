puts "each_slice"
(1..10).each_slice(3) { |slice| p slice }

puts "each_cons"
(1..10).each_cons(3) { |cons| p cons }
# each_slice
# [1, 2, 3]
# [4, 5, 6]
# [7, 8, 9]
# [10]
# each_cons
# [1, 2, 3]
# [2, 3, 4]
# [3, 4, 5]
# [4, 5, 6]
# [5, 6, 7]
# [6, 7, 8]
# [7, 8, 9]
# [8, 9, 10]
