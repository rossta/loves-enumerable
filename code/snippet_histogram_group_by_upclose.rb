file = File.open(File.expand_path("../../data/Thriller.txt", __FILE__), "r")
words = file.read.downcase.scan(%r{\b[a-z']{2,16}\b}i)

grouped = words.group_by { |w| w }
puts "Grouped", grouped.inspect

flattened = grouped.flat_map { |k, v| [k, v.size] }
puts "Flattened", flattened.inspect

# Grouped
# {"friend"=>["friend", "friend"], "though"=>["though"], "always"=>["always"], ...}
# Flattened
# ["friend", 2, "though", 1, "always", 1, ...]
