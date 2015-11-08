# from dgiim
letters = %w[a b c d e]

group_1 = letters.map.with_index do |item, index|
  [item, index % 3]
end

p group_1

group_2 = letters.reverse_each.group_by.each_with_index do |item, index|
  index % 3
end

p group_2

group_3 = letters.reverse_each.each_with_index.group_by do |item, index|
  index % 3
end

p group_3

[["a", 0], ["b", 1], ["c", 2], ["d", 0], ["e", 1]]
{0=>["e", "b"], 1=>["d", "a"], 2=>["c"]}
{0=>[["e", 0], ["b", 3]], 1=>[["d", 1], ["a", 4]], 2=>[["c", 2]]}
