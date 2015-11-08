sum = 0
(1..10).each { |n| sum += n }
p sum

p (1..10).reduce { |sum, n| sum + n }
p (1..10).reduce(:+)

product = 1
(1..10).each { |n| product *= n }
p product

p (1..10).reduce { |product, n| product * n }
p (1..10).reduce(:*)

# 55
# 55
# 55
# 3628800
# 3628800
# 3628800
