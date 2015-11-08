range = (1..Float::INFINITY)
p range.lazy.collect { |x| x * x }.first(10)
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
