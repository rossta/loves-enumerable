numbers = [23, 37, 18, 96, 41, 92, 72, 89, 94, 22]
start = 10

max = numbers.reduce(start) do |current_max, n|
  current_max > n ? current_max : n
end

puts "Max of #{numbers} is #{max}"
