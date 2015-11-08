# The sum of the squares of the first ten natural numbers is,
#
# 12 + 22 + ... + 102 = 385
# The square of the sum of the first ten natural numbers is,
#
# (1 + 2 + ... + 10)2 = 552 = 3025
# Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
#
# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

class Squares
  def sequence
    Enumerator.new do |y|
      n = s = 0
      loop do
        n += 1
        s += n ** 2
        y << s
      end
    end
  end
end

puts SumOfSquares.new.sequence.take(100).last
