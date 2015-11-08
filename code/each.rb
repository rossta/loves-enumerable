[1, 2, 3].each { |i| puts i }
include Enumerable
[1, 2, 3].each { |n| puts n }
p [1, 2, 3].map { |n| n * n }
p [1, 2, 3].any? { |n| n > 0 }
p [1, 2, 3].all? { |n| n > 1 }
p [1, 2, 3].any? { |n| n > 0 }

1
2
3
[1, 4, 9]
true
false
true
