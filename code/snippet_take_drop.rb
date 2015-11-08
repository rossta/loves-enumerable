# courtesy of JEG2

numbers = 1..10

p numbers.take(10)
p numbers.drop(10)

p numbers.take_while { |n| n <= 5 }
p numbers.drop_while { |n| n <= 5 }

[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
[]
[1, 2, 3, 4, 5]
[6, 7, 8, 9, 10]
